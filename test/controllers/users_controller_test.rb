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

  test 'POST #create redirects to the user page successfuly' do
    valid_new_user_params = {
      username: 'Joe Valid',
      email: 'valid@email.com',
      password: 'valid1pass',
      password_confirmation: 'valid1pass'
    }

    post signup_path, params: { user: valid_new_user_params }
    assert_redirected_to '/users/joe-valid'
  end

  test 'POST #create redirects to signup when invalid user params are passed' do
    invalid_new_user_params = {
      username: 'Joe InValid',
      email: 'invalidemail',
      password: 'pass',
      password_confirmation: 'pass2'
    }

    post signup_path, params: { user: invalid_new_user_params }
    assert_redirected_to '/signup'
  end
end
