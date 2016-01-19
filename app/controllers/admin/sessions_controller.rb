class Admin::SessionsController < ApplicationController
  layout "admin"

  def new
  end

  def create
    superuser = Superuser.find_by email: params[:session][:email].downcase
    if superuser && superuser.authenticate(params[:session][:password])
      log_in_superuser superuser
      redirect_to admin_root_path
    else
      flash[:danger] = t "application.flash.error_login"
      render :new
    end
  end

  def destroy
    log_out_superuser if logged_in_superuser?
    redirect_to admin_login_path
  end
end
