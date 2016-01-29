class UserCoursesController < ApplicationController
  before_filter :logged_in_user
  before_action :get_user_course_is_trainning, :get_course_subjects,
    :get_course_activity, only: [:show]
  before_action :get_user_course, only: [:update]

  def index
    @title_for_layout = t "user_courses.title"
    @user_courses = current_user.user_courses
  end

  def show
    @title_for_layout = t "header.calendar"
  end

  def update
    finish_course @user_course if @user_course.present?
    redirect_to calendar_path
  end

  private
  def get_user_course_is_trainning
    user_courses = current_user.user_courses
    @user_course = nil
    if user_courses.any?
      user_courses.each do |user_course|
        @user_course = user_course if user_course.trainning?
      end
    end 
  end

  def get_course_subjects
    @course_subjects = @user_course.course.course_subjects if @user_course.present?
  end

  def get_course_activity
    @activities = current_user.activities.get_course_activities @user_course.id if
      @user_course.present?
  end

  def get_user_course
    @user_course = current_user.user_courses.find params[:id]
  end

  def finish_course user_course
    user_course.update_status current_user.id
    course_subjects = user_course.course.course_subjects
    course_subjects.each do |course_subject|
      finish_subject course_subject, user_course
    end
  end

  def finish_subject course_subject, user_course
    course_subject.update_status current_user.id, user_course
    user_subject = current_user.user_subjects.find_by course_subject_id: course_subject.id
    user_subject.update_attributes status: :finish
    tasks = course_subject.course_subject_tasks
    tasks.each do |task|
      UserTask.create user_id: current_user, course_subject_task_id: task.id, status: :finish
    end
  end
end
