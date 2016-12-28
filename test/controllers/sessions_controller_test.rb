require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new session" do
    get new_session_path
    assert_response :success
  end

  test "should get create session failure" do
    user_login = users(:Alex)
    post session_path, params: { email: user_login.email, password: user_login.password }
    assert_response :redirect

  end

  # NOT WORKING
  test "should get create session" do
    user_login = User.last
    post session_path(user_login.id), params: { session: { email: user_login.email, password: user_login.password_digest } }
    assert_response :success
    assert_redirected_to games_path
  end

end
