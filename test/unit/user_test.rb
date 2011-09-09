require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "allow to destroy user if it is not the last one" do
    2.times { Factory(:user) }
    assert User.first.destroy
  end

  test "not allow to destroy user if it is the last one" do
    Factory(:user)
    assert !User.first.destroy
  end

  test "find user by email" do
    user = Factory(:user, :email => "john@doe.com")
    assert_equal user, User.find_by_smart_case_email_field("john@doe.com")
  end
end
