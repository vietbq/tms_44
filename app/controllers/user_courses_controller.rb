class UserCoursesController < ApplicationController
  before_filter :logged_in_user
  before_action :get_user_course_is_trainning, :get_course_subjects,
    :get_course_activity, only: [:show]

  def index
    @title_for_layout = t "user_courses.title"
    @user_courses = current_user.user_courses
  end

  def show
    @title_for_layout = t "header.calendar"
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
end 
