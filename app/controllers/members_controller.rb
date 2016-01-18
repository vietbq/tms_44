class MembersController < ApplicationController
  before_filter :logged_in_user
  def index
    @course = Course.find_by params[:id]
    if @course
      if @course.user_courses
        @user_courses = @course.user_courses
      end
      @title_for_layout = t("user_courses.users_list") + @course.name
    end
  end
end
