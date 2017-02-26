require 'test_helper'

class GameTest < ActiveSupport::TestCase
  def game_associations(association_type, property)
    Game.reflect_on_all_associations(association_type).select { |a| a.name == property }
  end

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
    expected_validation_rules = [:starts_with_non_whitespace, :ends_with_non_whitespace, :has_only_printable_characters]
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
    expected_validation_rules = [:starts_with_non_whitespace, :ends_with_non_whitespace, :has_only_printable_characters]
    assert_validates_format_rules expected_validation_rules, Game, :description
  end

  test 'generates a slug on validation' do
    game.validate
    assert_equal game.slug, 'game-title'
  end

  test 'with a slug that already exists, is invalid' do
    game_title_that_already_exists = games(:alex_adventures).title
    game.title = game_title_that_already_exists
    game.validate
    assert_includes game.errors[:slug], 'has already been taken'
  end

  test 'has many game screenshots' do
    associations = game_associations(:has_many, :game_screenshots)
    assert associations.one?
  end

  test 'has many game releases' do
    associations = game_associations(:has_many, :game_releases)
    assert associations.one?
  end

  test 'has and belongs to many users' do
    associations = game_associations(:has_and_belongs_to_many, :users)
    assert associations.one?
  end
end
