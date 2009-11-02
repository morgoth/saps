class User < ActiveRecord::Base
  has_many :posts, :dependent => :nullify

  acts_as_authentic do |c|
    c.act_like_restful_authentication = true
  end

  before_destroy :destroyable?

  attr_accessible :login, :password, :password_confirmation

  private

  def destroyable?
    User.count != 1
  end
end
