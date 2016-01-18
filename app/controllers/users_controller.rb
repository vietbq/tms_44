class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :load_user, only: [:show, :edit, :update]
  
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
end
