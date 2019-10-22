require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test 'GET #index is successful' do
    get dashboard_url
    assert_response :success
  end
end
