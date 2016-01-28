class Admin::SuperusersController < ApplicationController
  layout "admin"
  before_action :logged_in_superuser
  before_action :load_superuser, except: [:new, :create, :index]
  before_action :correct_superuser, only: [:edit, :update]

  def new
    @superuser = Superuser.new
  end

  def create
    @superuser = Superuser.new superuser_params
    if @superuser.save
      flash[:success] = t "admin.admin.created_admin"
      redirect_to admin_root_path
    else
      render :new
    end
  end

  def show
  end

  def index
    @superusers = Superuser.paginate page: params[:page]
  end

  def edit
  end

  def update
    if @superuser.update_attributes superuser_params
      flash[:success] = t "user.update_success"
      redirect_to admin_superuser_path @superuser
    else
      render :edit
    end
  end

  def destroy
    @superuser.destroy
    flash[:success] = t "admin.admin.deleted"
    redirect_to admin_superusers_path
  end

  private
  def superuser_params
    params.require(:superuser).permit :name, :email, :password,
      :password_confirmation
  end

  def load_superuser
    @superuser = Superuser.find params[:id]
  end

  def correct_superuser
    redirect_to admin_superuser_path @superuser unless current_superuser? @superuser
  end
end
