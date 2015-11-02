class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user

  def log_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_digest, User.digest(remember_token))
    self.current_user = user
    puts "Hey login method is called from SEssion controller!!!!!!!!!!!!!!!!"
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = cookies[:remember_token]
    if remember_token
      @current_user ||= User.find_by(remember_digest: User.digest(remember_token))
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def logged_in_user
    unless logged_in?
      redirect_to new_session_path
    end
  end

  def logout(user)
    user.update_attribute(:remember_digest, nil)
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end
