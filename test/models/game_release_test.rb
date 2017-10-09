require 'test_helper'

class GameReleaseTest < ActiveSupport::TestCase
  def game_release
    @game_release ||= GameRelease.new({
      version_num: 'v0.2.1',
      notes: 'Added faster clock',
      game: games(:alex_adventures)
    })
  end

  test 'validates without errors' do
    game_release.validate
    assert game_release.errors.empty?
  end

  test 'without a version_num, is invalid' do
    game_release.version_num = nil
    game_release.validate
    assert_includes game_release.errors[:version_num], "can't be blank"
  end

  test 'version_num must be unique for that game' do
    game_release.game = games(:alex_adventures)
    game_release.version_num = game_release.game.game_releases.first.version_num
    game_release.validate
    assert_includes game_release.errors[:version_num], 'already exists'
  end

  test 'version_num does not need to be unique globally' do
    game_release.game = games(:alex_adventures)
    game_release.version_num = games(:super_biker).game_releases.first.version_num
    game_release.validate
    refute_includes game_release.errors[:version_num], 'already exists'
  end

  test 'version_num is formatted with the expected rules' do
    expected_validation_rules = [:starts_with_non_whitespace, :ends_with_non_whitespace, :only_printable_characters]
    assert_validates_format_rules expected_validation_rules, GameRelease, :version_num
  end

  test 'belongs to a game' do
    assert_association GameRelease, :belongs_to, :game
  end

  test 'without a game, is invalid' do
    game_release.game = nil
    game_release.validate
    assert_includes game_release.errors[:game], 'must exist'
  end

  test 'has_many game files' do
    assert_association GameRelease, :has_many, :game_files
  end
end
