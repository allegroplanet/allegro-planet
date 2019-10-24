class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def record_not_found
    raise ActiveRecord::RecordNotFound.new('Not Found')
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
