class Admin::CourseSubjectsController < ApplicationController
  layout "admin"
  before_action :logged_in_superuser
  before_action :load_course_subject, only: [:update]

  def update
    if params[:status] == Settings.start
      start_subject
      flash[:success] = t "admin.subject.start_subject_success"
    else
      finish_subject
      flash[:success] = t "admin.subject.finish_subject_success"
    end
    redirect_to admin_course_path @course_subject.course
  end

  private
  def load_course_subject
    @course_subject = CourseSubject.find params[:id]
  end

  def start_subject
    @course_subject.update_attributes status: :trainning, start_date: Time.now
    @course_subject.user_subjects.each do |user_subject|
      user_subject.update_attributes status: :trainning
    end
  end

  def finish_subject
    @course_subject.update_attributes status: :finish, end_date: Time.now
    @course_subject.user_subjects.each do |user_subject|
      user_subject.update_attributes status: :finish
    end
  end
end
