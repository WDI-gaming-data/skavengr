class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_time_zone

  def is_authenticated?
  	unless current_user
  		flash[:danger] = "Authentication error"
  		redirect_to root_path
  	end
  end

  def set_time_zone
    Time.zone = "Pacific Time (US & Canada)"
  end

  def current_user
  	@current_user ||= User.find_by_id(session[:user_id])
  end
end
