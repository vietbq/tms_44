class Admin::UserSubjectsController < ApplicationController
  layout "admin"
  before_action :logged_in_superuser
  before_action :load_course, only: [:create]
  before_action :load_users, only: [:create]

  def create
    if users_not_busy?
      flash[:success] = t "admin.course.start_success"
      @users.each do |user|
        @course.course_subjects.each do |course_subject|
          course_subject.user_subjects.create user: user
        end
      end
      @course.update_attributes status: :trainning, start_date: Time.now
      update_user_courses
      redirect_to admin_courses_path
    else
      flash[:danger] = t "admin.course.start_error"
      redirect_to admin_courses_path
    end
  end

  private
  def load_course
    @course = Course.find params[:course_id]
  end

  def load_users
    @users = @course.load_users
  end

  def users_not_busy?
    check = true
    @users.each do |user|
      check = false if user.is_working?
    end
    check
  end

  def update_user_courses
    @users.each do |user|
      user_course = @course.user_courses.find_by user_id: user.id
      user_course.update_attributes status: :trainning
    end
  end
end
