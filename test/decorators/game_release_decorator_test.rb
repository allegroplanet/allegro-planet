require 'test_helper'

class GameReleaseDecoratorTest < ActiveSupport::TestCase
  def decorated_release(identifier)
    @decorated_release ||= GameReleaseDecorator.new(game_releases(identifier))
  end

  test '#version_num returns the expected version number' do
    version_num = decorated_release(:release_1).version_num
    assert_equal 'v0.0.1', version_num
  end

  test '#game_files returns the files associated with the game release' do
    skip
  end

  test '#notes returns the markdown release notes formated as HTML' do
    release_notes = decorated_release(:release_2).notes
    assert_equal "<p>Fixed problems with display</p>\n", release_notes
  end
end
