require 'test_helper'

class GameReleaseDecoratorTest < ActiveSupport::TestCase
  def decorated_release(identifier)
    @decorated_release ||= GameReleaseDecorator.new(game_releases(identifier))
  end

  test '#version_num returns the expected version number' do
    version_num = decorated_release(:alex_release_v1).version_num
    assert_equal 'v0.0.1', version_num
  end

  test '#game_files returns the files associated with the game release' do
    returned_game_files = decorated_release(:alex_release_v1).game_files
    expected_game_files = [
      { category: "Win binary", public_url: 'https://test-buhkit.s3.amazonaws.com/game-files/alex-v1-win32.zip' },
      { category: "MacOS binary", public_url: 'https://test-buhkit.s3.amazonaws.com/game-files/alex-v1-macos.zip' },
    ]

    assert_equal expected_game_files, returned_game_files
  end

  test '#notes returns the markdown release notes formated as HTML' do
    release_notes = decorated_release(:super_biker_release_v2).notes
    assert_equal "<p>Fixed problems with display</p>\n", release_notes
  end
end
