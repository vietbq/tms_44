module SessionsHelper
  def log_in_superuser superuser
    session[:superuser_id] = superuser.id
  end

  def current_superuser
    @current_superuser ||= Superuser.find_by(id: session[:superuser_id])
  end

  def current_superuser? superuser
    superuser == current_superuser
  end

  def logged_in_superuser?
    current_superuser.present?
  end

  def log_out_superuser
    session.delete :superuser_id
    @current_superuser = nil
  end

  def log_in user
    session[:user_id] = user.id
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user? user
    user == current_user
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by id: user_id
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by id: user_id
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    current_user.present?
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

  def redirect_back_or default
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
