class CoursesController < ApplicationController
  before_filter :logged_in_user

  def show
    @course = Course.find_by params[:id]
    if @course
      @course_subjects = @course.course_subjects
      @title_for_layout = @course.name
    end
  end
end
