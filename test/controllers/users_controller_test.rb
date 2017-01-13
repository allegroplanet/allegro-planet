require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def user
    @user ||= User.first
  end

  test 'GET #show is successful' do
    get user_path(user.slug)
    assert_response :success
  end

  test 'GET #show renders the "show" template' do
    get user_path(user.slug)
    assert_template :show
  end

  test 'GET #new is successful' do
    get signup_path
    assert_response :success
  end

  test 'GET #new renders the "new" template' do
    get signup_path
    assert_template :new
  end
end
