require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = FactoryGirl.create(:user)
  end

  test "reset password instuctions" do
    mail = UserMailer.password_reset_instructions(@user).deliver
    assert ActionMailer::Base.deliveries.present?
    assert_equal [@user.email], mail.to
  end
end
