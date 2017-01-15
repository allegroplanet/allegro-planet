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
    user.save
    assert_includes user.errors[:username], "can't be blank"
  end

  test 'username can not be longer than 24 characters' do
    username_too_long = 'a' * 25
    user.username = username_too_long
    user.save
    assert_includes user.errors[:username], 'is too long (maximum is 24 characters)'
  end

  test 'username must be unique' do
    already_existing_username = users(:markoates).username
    user.username = already_existing_username
    user.save
    assert_includes user.errors[:username], 'has already been taken'
  end

  test 'username must contain only printable characters' do
    user.username = "\x0A"
    user.save
    assert_includes user.errors[:username], 'can only contain printable characters'
  end

  test 'username can not end in whitespace' do
    user.username = 'endsinwhitespace '
    user.save
    assert_includes user.errors[:username], 'can not end with whitespace'
  end

  test 'username can not start with whitespace' do
    user.username = ' startswithwhitespace'
    user.save
    assert_includes user.errors[:username], 'can not start with whitespace'
  end

  test 'email must be present' do
    user.email = ''
    user.save
    assert_includes user.errors[:email], "can't be blank"
  end

  test 'email must be less that 255 characters' do
    too_long_email = 'a' * 256
    user.email = too_long_email
    user.save
    assert_includes user.errors[:email], 'is invalid'
  end

  test 'email must be valid' do
    user.email = 'an_invalid%^&*email'
    user.save
    assert_includes user.errors[:email], 'is invalid'
  end

  test 'email must be unique' do
    already_existing_email = users(:markoates).email
    user.email = already_existing_email
    user.save
    assert_includes user.errors[:email], 'has already been taken'
  end

  test 'email is saved in lowercase' do
    jumblecase_email = 'JuMbLeCaSe@EmAiL.CoM'
    user.email = jumblecase_email
    user.save
    user.reload
    assert_includes user.email, 'jumblecase@email.com'
  end

  test 'with a password less than 8 characters, is invalid' do
    user.password = 'pw2shrt'
    user.save
    assert_includes user.errors[:password], 'must have 8 or more characters'
  end

  test 'with a password that does not contain at least one digit, is invalid' do
    user.password = 'nodigits'
    user.save
    assert_includes user.errors[:password], 'must have at least one digit'
  end

  test 'with a password that starts with whitespace, is invalid' do
    user.password = ' startwithspace'
    user.save
    assert_includes user.errors[:password], 'can not start with whitespace'
  end

  test 'with a password that ends with whitespace, is invalid' do
    user.password = 'endswithspace '
    user.save
    assert_includes user.errors[:password], 'can not end with whitespace'
  end

  test 'generates a slug on validation' do
    user.save
    assert_equal user.slug, 'mr-test'
  end

  test 'with a slug that already exists, is invalid' do
    username_that_already_exists = users(:markoates).username
    user.username = username_that_already_exists
    user.save
    assert_includes user.errors[:slug], 'has already been taken'
  end
end
