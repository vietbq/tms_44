class UserCoursesController < ApplicationController
  before_filter :logged_in_user
  before_action :get_user, :get_user_course, :get_course_subjects, :get_activities, only: [:show]

  def index
    @title_for_layout = t "user_courses.title"
    @user_courses = current_user.user_courses
  end

  def show
  end

  private
  def get_user
    @user = User.find params[:user_id]
  end

  def get_user_course
    @user_course = @user.user_courses.find_by id: params[:id]
  end

  def get_course_subjects
    @course_subjects = @user_course.course.course_subjects
  end

  def get_activities
    @activities = @user.activities.limit Settings.activity_limit
  end
end
