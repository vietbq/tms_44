class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :logged_in_superuser

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "admin.user.created_user"
      redirect_to admin_root_path
    else
      render :new
    end
  end

  def index
    @users = User.paginate page: params[:page]
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
