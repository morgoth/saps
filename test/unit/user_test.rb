require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "find user by email" do
    user = Factory(:user, :email => "john@doe.com")
    assert_equal user, User.find_by_smart_case_email_field("john@doe.com")
  end
end
