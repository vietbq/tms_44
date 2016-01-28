class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :logged_in_superuser
  before_action :load_user, except: [:new, :create, :index]

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

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "admin.user.updated"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t "admin.user.deleted"
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    @user = User.find params[:id]
  end
end
