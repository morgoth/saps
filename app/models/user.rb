class User < ActiveRecord::Base
  has_many :posts, :dependent => :nullify

  validates_presence_of :login
  validate :login_not_changed, :on => :update

  acts_as_authentic do |c|
    c.act_like_restful_authentication = true
  end

  attr_accessible :login, :password, :password_confirmation
  before_destroy :destroyable?

  private

  def login_not_changed
    errors.add :login, :changed if login_changed?
  end

  def destroyable?
    User.count != 1
  end
end
