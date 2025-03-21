require "test_helper"

class MysaunasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # users.yml の one ユーザーをセット
    log_in_as(@user)    # ヘルパーでログイン（無い場合は追加する）
    @mysauna = @user.mysauna # fixtureで紐づけたmysaunaを取得
  end

  test "should get new" do
    get new_mysauna_url
    assert_response :success
  end

  test "should create mysauna" do
    post mysaunas_url, params: { mysauna: { sauna_name: "Test Sauna", comment: "Great place!" } }
    assert_response :redirect
  end

  test "should get edit" do
    get edit_mysauna_url(@mysauna.id)
    assert_response :success
  end
  
  test "should update mysauna" do
    patch mysauna_url(@mysauna.id), params: { mysauna: { sauna_name: "Updated Sauna" } }
    assert_response :redirect
  end
  
  test "should destroy mysauna" do
    delete mysauna_url(@mysauna.id)
    assert_response :redirect
  end
end
