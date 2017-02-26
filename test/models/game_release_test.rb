require 'test_helper'

class GameReleaseTest < ActiveSupport::TestCase
  def game_release_associations(association_type, property)
    GameRelease.reflect_on_all_associations(association_type).select { |a| a.name == property }
  end

  test 'belongs to a game' do
    associations = game_release_associations(:belongs_to, :game)
    assert associations.one?
  end
end
