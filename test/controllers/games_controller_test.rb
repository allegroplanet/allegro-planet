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
end
