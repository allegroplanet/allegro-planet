class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def record_not_found
    raise ActiveRecord::RecordNotFound.new('Not Found')
  end
end
