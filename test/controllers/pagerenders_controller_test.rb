require 'test_helper'

class PagerendersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get games_url
    assert_response :success
  end

  test "should get new" do
    get new_game_url
    assert_response :success
  end

  test "should create game" do
    assert_difference('Pagerender.count') do
      post games_url, params: { game: { url: @game.url } }
    end

    assert_redirected_to game_url(Pagerender.last)
  end

  test "should show game" do
    get game_url(@game)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_url(@game)
    assert_response :success
  end

  test "should update game" do
    patch game_url(@game), params: { game: { url: @game.url } }
    assert_redirected_to game_url(@game)
  end

  test "should destroy game" do
    assert_difference('Pagerender.count', -1) do
      delete game_url(@game)
    end

    assert_redirected_to games_url
  end
end
