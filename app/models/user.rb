require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :posts, :dependent => :nullify

  acts_as_authentic do |c|
    c.act_like_restful_authentication = true
  end

  attr_accessible :login, :password, :password_confirmation

   def safe_delete
     transaction do
       destroy
       if User.count.zero?
         raise "Nie można usunąć ostatniego administratora"
       end
     end
   end
end
