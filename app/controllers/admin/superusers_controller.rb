class Admin::SuperusersController < ApplicationController
  layout "admin"
  before_action :logged_in_superuser, only: [:edit, :update]
  before_action :correct_superuser, only: [:edit, :update]

  def show
  end

  def edit
    @superuser = Superuser.find params[:id]
  end

  def update
    @superuser = Superuser.find params[:id]
    if @superuser.update_attributes superuser_params
      flash[:success] = t "user.update_success"
      redirect_to admin_superuser_path @superuser
    else
      render :edit
    end
  end

  private
  def superuser_params
    params.require(:superuser).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_superuser
    @superuser = Superuser.find params[:id]
    redirect_to admin_superuser_path @superuser unless current_superuser? @superuser
  end
end
