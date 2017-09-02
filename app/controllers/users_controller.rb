class UsersController < ApplicationController
  def show
    @user = User.find_by(handle: params[:handle]) or record_not_found
    @description = MarkdownConverter.new(@user.description).html
    @games = @user.games
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(handle: @user)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
