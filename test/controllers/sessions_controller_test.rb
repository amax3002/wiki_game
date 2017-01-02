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

  test "should get create session" do
    new_session(:Alex)
    follow_redirect!
    assert_select "h1", "Choose Game"
  end

  test "should destroy session" do
    new_session(:Alex)
    follow_redirect!

    delete session_path
    follow_redirect!
    assert_select "small", "Indulge desire for knowledge with vanquishing your enemies"
  end

end
