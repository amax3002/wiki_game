require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "create user" do
    post "/users", params: { user: { email: "amax3002@aol.com", full_name: "Twiggy Guy", password: "password", password_confirmation: "password" } }
    assert_response :redirect
    assert_equal User.last.full_name, "Twiggy Guy"
  end

  test "show specific user information" do
    new_session(:Alex)
    get user_path(users(:Alex))

    assert_select "h1", "Client Details for Alex Guy"
  end

  test "delete specific user information" do
    new_session(:Laurent)
    user_to_be_deleted = User.last
    delete user_path(user_to_be_deleted)

    assert_redirected_to root_url
    assert_raise ActiveRecord::RecordNotFound do
      User.find(user_to_be_deleted.id)
    end
  end

  test "should be able to update a User's ifo" do
    new_session(:Alex)
    user_id = users(:Alex).id
    patch user_path(user_id), params: { user: { full_name: "Dis Guy" } }
    assert_response :redirect
    assert_equal "Dis Guy", User.find(user_id).full_name
  end

end
