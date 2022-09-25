require "test_helper"

class Admin::TweetsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_tweets_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_tweets_edit_url
    assert_response :success
  end
end
