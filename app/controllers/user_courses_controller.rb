class UserCoursesController < ApplicationController
  def index
    @title_for_layout = t "user_courses.title"
    @user_courses = current_user.user_courses
  end
end
