class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper

  def authenticate_user(options = {})
    unless current_user || options.fetch(:except, []).include?(request[:action])
      redirect_to login_path, notice: "You need to login before continuing."
    end
  end
end
