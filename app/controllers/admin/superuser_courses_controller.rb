class Admin::SuperuserCoursesController < ApplicationController
  layout "admin"
  before_action :logged_in_superuser

  def new
  end

  def create
    @superuser = Superuser.find_by email: params[:email]
    @course = Course.find params[:course_id]
    if @superuser.nil?
      flash[:danger] = t "admin.course.email_not_found"
      render :new
    else
      add_admin_to_course
    end
  end

  private
  def add_admin_to_course
    if @course.managed_by? @superuser
      flash[:warning] = t "admin.course.admin_was_added"
      render :new
    else
      SuperuserCourse.create superuser: @superuser, course: @course
      flash[:success] = t "admin.course.add_admin_success"
      redirect_to admin_course_path(@course)
    end
  end
end
