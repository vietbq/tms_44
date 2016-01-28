class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :load_user, :get_user_course, only: [:show, :edit, :update]
  include UserSubjectsHelper
  include UserCoursesHelper

  def show
  end
  
  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile.updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def load_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def get_user_course
    @user_courses = @user.user_courses
  end
end
