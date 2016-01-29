class Admin::UserCoursesController < ApplicationController
  layout "admin"
  before_action :logged_in_superuser
  before_action :load_course, only: [:create, :destroy]
  before_action :load_user_course, only: [:destroy]
  before_action :load_objects, only: [:show]

  def show
  end

  def new
  end

  def create
    @user = User.find_by email: params[:email]
    if @user.nil?
      flash[:danger] = t "admin.course.email_not_found"
      render :new
    else
      add_user_to_course
    end
  end

  def destroy
    @user_course.destroy
    flash[:success] = t "admin.course.delete_user"
    redirect_to admin_course_path @course
  end

  private
  def load_course
    @course = Course.find params[:course_id]
  end

  def load_user_course
    @user_course = UserCourse.find params[:id]
  end

  def load_objects
    @course = Course.find params[:course_id]
    @user_course = UserCourse.find params[:id]
    @user = @user_course.user
    @subjects = @course.load_subjects
  end

  def add_user_to_course
    if @course.has_user? @user
      flash[:warning] = t "admin.course.user_was_added"
      render :new
    else
      UserCourse.create user: @user, course: @course
      flash[:success] = t "admin.course.add_user_success"
      redirect_to admin_course_path @course
    end
  end
end
