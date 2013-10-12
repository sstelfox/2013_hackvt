class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user
    unless current_user
      redirect_to login_path, notice: "You need to login before continuing."
    end
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
end
