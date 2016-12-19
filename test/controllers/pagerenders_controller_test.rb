require 'test_helper'

class PagerendersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pagerender = pagerenders(:one)
  end

  test "should get index" do
    get pagerenders_url
    assert_response :success
  end

  test "should get new" do
    get new_pagerender_url
    assert_response :success
  end

  test "should create pagerender" do
    assert_difference('Pagerender.count') do
      post pagerenders_url, params: { pagerender: { url: @pagerender.url } }
    end

    assert_redirected_to pagerender_url(Pagerender.last)
  end

  test "should show pagerender" do
    get pagerender_url(@pagerender)
    assert_response :success
  end

  test "should get edit" do
    get edit_pagerender_url(@pagerender)
    assert_response :success
  end

  test "should update pagerender" do
    patch pagerender_url(@pagerender), params: { pagerender: { url: @pagerender.url } }
    assert_redirected_to pagerender_url(@pagerender)
  end

  test "should destroy pagerender" do
    assert_difference('Pagerender.count', -1) do
      delete pagerender_url(@pagerender)
    end

    assert_redirected_to pagerenders_url
  end
end
