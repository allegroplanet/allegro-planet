require 'test_helper'

class GameFileTest < ActiveSupport::TestCase
  def game_file
    @game_file ||= GameFile.new({
      file: 'filename.zip',
      category: 'Source files',
      game_release: game_releases(:super_biker_release_v2)
    })
  end

  test 'validates without errors' do
    game_file.validate
    assert game_file.errors.empty?
  end

  test 'without a category, is invalid' do
    game_file.category = nil
    game_file.validate
    assert_includes game_file.errors[:category], GameFile::INCLUSION_MESSAGE
  end

  test 'can have a valid category' do
    GameFile::GAME_FILE_CATEGORIES.each do |category|
      game_file.category = category
      game_file.validate
      assert game_file.errors[:category].empty?
    end
  end

  test 'with an category that is not a known category, is invalid' do
    game_file.category = 'Not a known category'
    game_file.validate
    assert_includes game_file.errors[:category], GameFile::INCLUSION_MESSAGE
  end

  test 'belongs_to to a game_release' do
    assert_association GameFile, :belongs_to, :game_release
  end

  test 'has the expected category error message' do
    assert_equal GameFile::INCLUSION_MESSAGE, "must be one of #{GameFile::GAME_FILE_CATEGORIES}"
  end

  test '#public_url returns the expected url' do
    returned_url = game_files(:win_32_binary).public_url
    expected_url = "https://test-buhkit.s3.amazonaws.com/game-files/alex-v1-win32.zip"
    assert_equal expected_url, returned_url
  end
end
