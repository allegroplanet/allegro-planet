class UsersController < ApplicationController
  def show
    @user = User.find_by(slug: params[:slug]) or record_not_found
  end
end
