require "test_helper"

class MysaunasControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @user.mysauna&.destroy
    log_in_as(@user)
  end

  test "should get new" do
    get mysaunas_new_path
    assert_response :success
  end

  test "should get edit" do
    @mysauna = @user.create_mysauna(sauna_name: "テストサウナ", comment: "テストコメント")
    get edit_mysauna_path(@mysauna)
    assert_response :success
  end

  test "should update mysauna" do
    @mysauna = @user.create_mysauna(sauna_name: "テストサウナ", comment: "テストコメント")
    patch mysauna_path(@mysauna), params: { mysauna: { sauna_name: "更新サウナ" } }
    assert_redirected_to mypage_user_path(@user)
  end

  test "should destroy mysauna" do
    @mysauna = @user.create_mysauna(sauna_name: "テストサウナ", comment: "テストコメント")
    assert_difference("Mysauna.count", -1) do
      delete mysauna_path(@mysauna)
    end
    assert_redirected_to mypage_user_path(@user)
  end
end
