require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test 'GET #index is successful' do
    get depot_url
    assert_response :success
  end
end
