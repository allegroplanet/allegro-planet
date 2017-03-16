require 'test_helper'

class GameScreenshotTest < ActiveSupport::TestCase
  def game_screenshot_associations(association_type, property)
    GameScreenshot.reflect_on_all_associations(association_type).select { |a| a.name == property }
  end

  test 'belongs to a game' do
    associations = game_screenshot_associations(:belongs_to, :game)
    assert associations.one?
  end
end
