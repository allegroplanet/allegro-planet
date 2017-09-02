require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test 'GET #index is successful' do
    get search_url
    assert_response :success
  end

  test 'GET #index with a query is successful' do
    get search_url, params: { q: 'duck' }
    assert_response :success
  end
end
