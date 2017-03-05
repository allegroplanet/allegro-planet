require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test 'GET #index is successful' do
    get games_url
    assert_response :success
  end

  test 'GET #show is successful' do
    get game_path(games(:alex_adventures))
    assert_response :success
  end

  test '#show responds with the game description in HTML' do
    get game_path(games(:super_biker))
    assert_match '<p>A fast-paced action <em>racer</em>.</p>', response.body
  end
end
