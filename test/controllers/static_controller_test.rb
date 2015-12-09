require 'test_helper'

class StaticControllerTest < ActionController::TestCase

  include Devise::TestHelpers
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Paul & Katie's Wedding :: Welcome"
  end

  test "should get story" do
    get :story
    assert_response :success
    assert_select "title", "Paul & Katie's Wedding :: Story"
  end
 
  test "should get event" do
    get :event
    assert_response :success
    assert_select "title", "Paul & Katie's Wedding :: Event"
  end

  test "should get registries" do
    get :registries
    assert_response :success
    assert_select "title", "Paul & Katie's Wedding :: Registries"
  end

  test "should get rsvp" do
    get :rsvp
    assert_response :success
    assert_select "title", "Paul & Katie's Wedding :: RSVP"
  end

end