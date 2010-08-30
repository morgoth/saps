class User < ActiveRecord::Base
  has_many :posts, :dependent => :nullify

  validates_presence_of :login, :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => Authlogic::Regex.email

  acts_as_authentic do |c|
    c.act_like_restful_authentication = true
  end

  attr_accessible :login, :email, :password, :password_confirmation
  before_destroy :destroyable?

  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.password_reset_instructions(self).deliver
  end

  private

  def destroyable?
    User.count != 1
  end
end
