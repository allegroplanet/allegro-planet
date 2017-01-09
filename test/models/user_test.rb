require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'creates a new user in the database' do
    User.destroy_all
    new_user = User.create!(username: 'mr. test', email: 'test@email.com')
    assert_equal User.count, 1
  end

  test 'username must be present' do
    new_user = User.create
    assert_includes new_user.errors[:username], "can't be blank"
  end

  test 'username can not be longer than 24 characters' do
    too_long_username = 'a' * 25
    new_user = User.create(username: too_long_username)
    assert_includes new_user.errors[:email], 'is invalid'
  end

  test 'email must be present' do
    new_user = User.create
    assert_includes new_user.errors[:email], "can't be blank"
  end

  test 'email must be less that 255 characters' do
    too_long_email = 'a' * 256
    new_user = User.create(email: too_long_email)
    assert_includes new_user.errors[:email], 'is invalid'
  end

  test 'email must be valid' do
    new_user = User.create(email: 'an_invalid%^&*email')
    assert_includes new_user.errors[:email], 'is invalid'
  end
end
