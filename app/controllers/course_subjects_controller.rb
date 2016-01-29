class CourseSubjectsController < ApplicationController
  before_filter :logged_in_user
  before_action :get_course_subject, :get_user_course, only: [:update]
  include UserCoursesHelper

  def update
    finish_subject @course_subject if @course_subject.present? &&
      @user_course.present?
    redirect_to calendar_path
  end

  private
  def get_course_subject
    @course_subject = CourseSubject.find params[:id]
  end

  def get_user_course
    @user_course = current_user.user_courses.find_by course_id: @course_subject.
      course if @course_subject.present?
  end
end
