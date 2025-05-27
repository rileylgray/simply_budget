require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should create session" do
    user = users(:one) # Assuming you have a fixture for users
    post sessions_url, params: { session: { email: user.email, password: "password" } }
    assert_redirected_to user_path(user)
    follow_redirect!
    assert_select "h1", "Welcome, #{user.name}"
  end

  test "should destroy session" do
    delete logout_url
    assert_redirected_to root_url
  end
end
