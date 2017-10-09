require 'test_helper'

class GameTest < ActiveSupport::TestCase
  def game
    @game ||= Game.new(title: 'Game Title', description: 'The best game ever.')
  end

  test 'validates without errors' do
    game.validate
    assert game.errors.empty?
  end

  test 'without a unique title, is invalid' do
    game.title = games(:alex_adventures).title
    game.validate
    assert_includes game.errors[:title], 'has already been taken'
  end

  test 'without a title, is invalid' do
    game.title = nil
    game.validate
    assert_includes game.errors[:title], "can't be blank"
  end

  test 'with blank title, is invalid' do
    game.title = ''
    game.validate
    assert_includes game.errors[:title], "can't be blank"
  end

  test 'title is formatted with the expected rules' do
    expected_validation_rules = [:starts_with_non_whitespace, :ends_with_non_whitespace, :only_printable_characters]
    assert_validates_format_rules expected_validation_rules, Game, :title
  end

  test 'without a description, is invalid' do
    game.description = nil
    game.validate
    assert_includes game.errors[:description], "can't be blank"
  end

  test 'with a blank description, is invalid' do
    game.description = ''
    game.validate
    assert_includes game.errors[:description], "can't be blank"
  end

  test 'description is formatted with the expected rules' do
    expected_validation_rules = [:starts_with_non_whitespace, :ends_with_non_whitespace, :only_printable_characters_and_newlines]
    assert_validates_format_rules expected_validation_rules, Game, :description
  end

  test 'generates a handle on validation' do
    game.validate
    assert_equal game.handle, 'game-title'
  end

  test 'with a handle that already exists, is invalid' do
    game_title_that_already_exists = games(:alex_adventures).title
    game.title = game_title_that_already_exists
    game.validate
    assert_includes game.errors[:handle], 'has already been taken'
  end

  test 'has many game screenshots' do
    assert_association Game, :has_many, :game_screenshots
  end

  test 'has many game releases' do
    assert_association Game, :has_many, :game_releases
  end

  test 'has and belongs to many users' do
    assert_association Game, :has_and_belongs_to_many, :users
  end
end
