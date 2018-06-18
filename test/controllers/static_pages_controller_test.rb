require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

<<<<<<< 3f3429b2759f8bcddce543ea1644081fa603aa3c
  test "should get about" do
    get static_pages_about_url
    assert_response :success
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
  end

end
