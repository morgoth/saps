class User < ActiveRecord::Base
  has_many :posts, :dependent => :nullify

  validates_presence_of :login, :email
  validates_format_of :email, :with => Authlogic::Regex.email
  validate :login_not_changed, :on => :update

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

  def login_not_changed
    errors.add :login, :changed if login_changed?
  end

  def destroyable?
    User.count != 1
  end
end
