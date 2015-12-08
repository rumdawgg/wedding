require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
include Devise::TestHelpers
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to "/users/sign_in"
  end
end
