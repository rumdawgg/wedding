require 'test_helper'

class UsersControllerTest < ActionController::TestCase
    include Devise::TestHelpers

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to new_user_session_path
  end

end
