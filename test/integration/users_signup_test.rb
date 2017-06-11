require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "不正なサインアップ" do
    get signup_path
    assert_no_difference "User.count" do # userが増えないことを確認
      post users_path, params: { user: {
          name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar"}}
    end
    assert_template "users/new"
    assert_select "div#error_explanation"
    assert_select "div#error_explanation li", minimum: 4
  end

  test "正常なサインアップ（同時にログイン）" do
    get signup_path
      assert_difference "User.count", 1 do
        post users_path, params: { user: {
            name: "sample man",
            email: "sample@railstutorial.org",
            password: "password",
            password_confirmation: "password"}}
      end
    assert_select "div#error_explanation", false
    follow_redirect!
    assert_template 'users/show'
    assert_not flash[:error]
    assert is_logged_in?
  end
end
