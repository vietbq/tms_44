class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "user.pls_login"
      redirect_to login_url
    end
  end

  def logged_in_superuser
    unless logged_in_superuser?
      flash[:danger] = t "user.pls_login"
      redirect_to admin_login_path
    end
  end
end
