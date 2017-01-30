require 'test_helper'

class GameTest < ActiveSupport::TestCase
  def game
    @game ||= Game.new(title: 'Game Title', description: 'The best game ever.')
  end

  test 'saves a game to the database' do
    Game.destroy_all
    game.save
    assert game.errors.empty?
    assert_equal 1, Game.count
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
end
