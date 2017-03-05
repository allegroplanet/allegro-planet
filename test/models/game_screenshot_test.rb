require 'test_helper'

class GameScreenshotTest < ActiveSupport::TestCase
  def game_screenshot_associations(association_type, property)
    GameScreenshot.reflect_on_all_associations(association_type).select { |a| a.name == property }
  end

  test 'belongs to a game' do
    associations = game_screenshot_associations(:belongs_to, :game)
    assert associations.one?
  end

  test '#public_url returns the expected url' do
    returned_url = game_screenshots(:alex_screenshot_1).public_url
    expected_url = "https://test-buhkit.s3.amazonaws.com/screenshots/title-screen-screenshot.jpg"
    assert_equal expected_url, returned_url
  end
end
