class DashboardController < ApplicationController
  def index
    user = User.find(session_user_id) or record_not_found

    @games = Games.where(user_id: session_user_id)
    @articles = []
  end

  private

  def session_user_id
    session[:user_id]
  end
end
