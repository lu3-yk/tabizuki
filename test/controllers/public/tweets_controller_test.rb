require "test_helper"

class Public::TweetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_tweets_new_url
    assert_response :success
  end

  test "should get create" do
    get public_tweets_create_url
    assert_response :success
  end

  test "should get index" do
    get public_tweets_index_url
    assert_response :success
  end

  test "should get show" do
    get public_tweets_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_tweets_edit_url
    assert_response :success
  end
end
