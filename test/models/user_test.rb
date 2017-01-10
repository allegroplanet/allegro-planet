require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'creates a new user in the database' do
    User.destroy_all
    new_user = User.create!(username: 'mr. test',
                            email: 'test@email.com',
                            password: 'pass',
                            password_confirmation: 'pass'
                           )
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

  test 'username must be unique' do
    already_existing_username = users(:markoates).username
    new_user = User.create(username: already_existing_username)
    assert_includes new_user.errors[:username], 'has already been taken'
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

  test 'email must be unique' do
    already_existing_email = users(:markoates).email
    new_user = User.create(email: already_existing_email)
    assert_includes new_user.errors[:email], 'has already been taken'
  end

  test 'email is saved in lowercase' do
    jumblecase_email = 'JuMbLeCaSe@EmAiL.CoM'
    new_user = User.create(username: 'Mrs. Jumble', email: jumblecase_email)
    new_user.save
    new_user.reload
    assert_includes new_user.email, 'jumblecase@email.com'
  end
end
