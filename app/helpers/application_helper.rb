module ApplicationHelper
  def current_user
    return unless session[:user_id]
    return session[:user_id] = nil unless User.exists?(id: session[:user_id])

    @current_user ||= User.find(session[:user_id]) 
  end
end
