class LoginsController < ApplicationController
  def new
    #@login = Login.new
  end

  def create
    Login.new
    user = User.find_by(username: username_param)
    user.password = password_param if user

    if user.valid?
      redirect_to user_path(handle: @user)
    else
      render :new
    end
  end

  def destroy
  end

  private

  def username_param
    params.permit(:username)[:username]
  end

  def password_param
    params.permit(:password)[:password]
  end
end
