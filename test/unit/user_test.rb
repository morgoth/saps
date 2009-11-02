require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should "allow to destroy user if it is not the last one" do
    2.times { Factory(:user) }
    assert User.first.destroy
  end

  should "not allow to destroy user if it is the last one" do
    Factory(:user)
    assert !User.first.destroy
  end
end