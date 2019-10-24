require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def user
    @user ||= User.new(username: 'mr. test',
                       email: 'test@email.com',
                       password: 'pass1word',
                       password_confirmation: 'pass1word'
                      )
  end

  test 'creates a new user in the database' do
    User.destroy_all
    user.save
    assert_equal User.count, 1
  end

  test 'username must be present' do
    user.username = ''
    user.validate
    assert_includes user.errors[:username], "can't be blank"
  end

  test 'username can not be longer than 24 characters' do
    username_too_long = 'a' * 25
    user.username = username_too_long
    user.validate
    assert_includes user.errors[:username], 'is too long (maximum is 24 characters)'
  end

  test 'username must be at least 2 characters' do
    username_too_short = 'B'
    user.username = username_too_short
    user.validate
    assert_includes user.errors[:username], 'is too short (minimum is 2 characters)'
  end

  test 'username must be unique' do
    already_existing_username = users(:markoates).username
    user.username = already_existing_username
    user.validate
    assert_includes user.errors[:username], 'has already been taken'
  end

  test 'username must contain only the allowed characters' do
    user.username = "\x0A"
    user.validate
    assert_includes user.errors[:username], "can only contain alphanumeric, '-', '_', space, '.', and '~' characters"
  end

  test 'username must have at least one alphanumeric character' do
    user.username = "_-~"
    user.validate
    assert_includes user.errors[:username], 'must contain at least one alphanumeric character'
  end

  test 'username can not end in whitespace' do
    user.username = 'endsinwhitespace '
    user.validate
    assert_includes user.errors[:username], "can't end with whitespace"
  end

  test 'username can not start with whitespace' do
    user.username = ' startswithwhitespace'
    user.validate
    assert_includes user.errors[:username], "can't start with whitespace"
  end

  test 'email must be present' do
    user.email = ''
    user.validate
    assert_includes user.errors[:email], "can't be blank"
  end

  test 'email must be valid' do
    user.email = 'an_invalid%^&*email'
    user.validate
    assert_includes user.errors[:email], 'must be a valid email'
  end

  test 'email must be unique' do
    already_existing_email = users(:markoates).email
    user.email = already_existing_email
    user.validate
    assert_includes user.errors[:email], 'has already been taken'
  end

  test 'email is saved in lowercase' do
    jumblecase_email = 'JuMbLeCaSe@EmAiL.CoM'
    user.email = jumblecase_email
    user.save
    user.reload
    assert_includes user.email, 'jumblecase@email.com'
  end

  test 'password must be present on creation' do
    User.destroy_all
    user.password = nil
    refute user.save
  end

  test 'with a password less than 3 characters, is invalid' do
    user.password = 'pw'
    user.validate
    assert_includes user.errors[:password], 'is too short (minimum is 3 characters)'
  end

  test 'with a password that contains non-printable characters, is invalid' do
    user.password = "\0x07"
    user.validate
    assert_includes user.errors[:password], 'can only contain printable characters'
  end

  test 'a password on an exiting user does not require re-validation' do
    user_from_database = users(:markoates)
    assert user_from_database.validate
  end

  test 'generates a handle on validation' do
    user.validate
    assert_equal user.handle, 'mr-test'
  end

  test 'with a handle that already exists, is invalid' do
    username_that_already_exists = users(:markoates).username
    user.username = username_that_already_exists
    user.validate
    assert_includes user.errors[:handle], 'has already been taken'
  end

  test 'has and belongs to many games' do
    assert_association User, :has_and_belongs_to_many, :games
  end
end
