require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def user
    @user ||= User.first
  end

  test 'GET #show is successful' do
    get user_path(user.slug)
    assert_response :success
  end
end
