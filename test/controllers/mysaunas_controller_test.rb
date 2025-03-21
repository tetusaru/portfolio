require "test_helper"

class MysaunasControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get mysaunas_new_url
    assert_response :success
  end

  test "should get create" do
    get mysaunas_create_url
    assert_response :success
  end

  test "should get edit" do
    get mysaunas_edit_url
    assert_response :success
  end

  test "should get update" do
    get mysaunas_update_url
    assert_response :success
  end

  test "should get destroy" do
    get mysaunas_destroy_url
    assert_response :success
  end
end
