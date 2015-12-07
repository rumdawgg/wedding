require 'test_helper'

class UsersControllerTest < ActionController::TestCase
    include Devise::TestHelpers

      def setup
        @user = users(:paul)
        @other_user = users(:katie)
      end

end
