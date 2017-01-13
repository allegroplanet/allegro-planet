class UsersController < ApplicationController
  def show
    @user = User.find_by(slug: params[:slug]) or record_not_found
  end

  def new
    @user = User.new
  end
end
