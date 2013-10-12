module ApplicationHelper
  def current_user
    return nil unless session[:user_id]
    return session[:user_id] = nil unless User.exists?(id: session[:user_id])
    User.find(session[:user_id]) 
  end
end
