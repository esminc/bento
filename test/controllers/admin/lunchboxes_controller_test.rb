require 'test_helper'

class Admin::LunchboxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lunchbox = lunchboxes(:one)
  end

  test "should get index" do
    get lunchboxes_url
    assert_response :success
  end

  test "should get new" do
    get new_lunchbox_url
    assert_response :success
  end

  test "should create lunchbox" do
    assert_difference('Lunchbox.count') do
      post lunchboxes_url, params: { lunchbox: {  } }
    end

    assert_redirected_to lunchbox_url(Lunchbox.last)
  end

  test "should show lunchbox" do
    get lunchbox_url(@lunchbox)
    assert_response :success
  end

  test "should get edit" do
    get edit_lunchbox_url(@lunchbox)
    assert_response :success
  end

  test "should update lunchbox" do
    patch lunchbox_url(@lunchbox), params: { lunchbox: {  } }
    assert_redirected_to lunchbox_url(@lunchbox)
  end

  test "should destroy lunchbox" do
    assert_difference('Lunchbox.count', -1) do
      delete lunchbox_url(@lunchbox)
    end

    assert_redirected_to lunchboxes_url
  end
end
