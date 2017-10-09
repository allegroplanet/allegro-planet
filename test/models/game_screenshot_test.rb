require 'test_helper'

class GameScreenshotTest < ActiveSupport::TestCase
  test 'belongs to a game' do
    assert_association GameScreenshot, :belongs_to, :game
  end

  test '#feature_public_url returns the expected url' do
    returned_url = game_screenshots(:alex_screenshot_1).feature_public_url
    expected_url = "https://test-buhkit.s3.amazonaws.com/screenshots/feature_title-screen-screenshot.jpg"
    assert_equal expected_url, returned_url
  end

  test '#tile_public_url returns the expected url' do
    returned_url = game_screenshots(:alex_screenshot_1).tile_public_url
    expected_url = "https://test-buhkit.s3.amazonaws.com/screenshots/tile_title-screen-screenshot.jpg"
    assert_equal expected_url, returned_url
  end

  test '#thumb_public_url returns the expected url' do
    returned_url = game_screenshots(:alex_screenshot_1).thumb_public_url
    expected_url = "https://test-buhkit.s3.amazonaws.com/screenshots/thumb_title-screen-screenshot.jpg"
    assert_equal expected_url, returned_url
  end
end
