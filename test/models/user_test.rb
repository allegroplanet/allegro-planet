require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def user_associations(association_type, property)
    User.reflect_on_all_associations(association_type).select { |a| a.name == property }
  end

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
    assert_includes user.errors[:username], "can't end with whitespace"
  end

  test 'username can not start with whitespace' do
    user.username = ' startswithwhitespace'
    user.save
    assert_includes user.errors[:username], "can't start with whitespace"
  end

  test 'email must be present' do
    user.email = ''
    user.save
    assert_includes user.errors[:email], "can't be blank"
  end

  test 'email must be valid' do
    user.email = 'an_invalid%^&*email'
    user.save
    assert_includes user.errors[:email], 'must be a valid email'
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
    assert_includes user.errors[:password], 'is too short (minimum is 8 characters)'
  end

  test 'with a password that starts with whitespace, is invalid' do
    user.password = ' startwithspace'
    user.save
    assert_includes user.errors[:password], "can't start with whitespace"
  end

  test 'with a password that ends with whitespace, is invalid' do
    user.password = 'endswithspace '
    user.save
    assert_includes user.errors[:password], "can't end with whitespace"
  end

  test 'with a password that contains non-printable characters, is invalid' do
    user.password = "\0x07"
    user.save
    assert_includes user.errors[:password], 'can only contain printable characters'
  end

  test 'generates a handle on validation' do
    user.save
    assert_equal user.handle, 'mr-test'
  end

  test 'with a handle that already exists, is invalid' do
    username_that_already_exists = users(:markoates).username
    user.username = username_that_already_exists
    user.save
    assert_includes user.errors[:handle], 'has already been taken'
  end

  test 'has and belongs to many games' do
    associations = user_associations(:has_and_belongs_to_many, :games)
    assert associations.one?
  end
end
