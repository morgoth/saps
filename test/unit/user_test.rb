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

  test "not allow to change login" do
    user = Factory(:user, :login => "john")
    user.login = "nasty"
    assert_false user.valid?
    assert user.errors[:login].present?
  end
end
