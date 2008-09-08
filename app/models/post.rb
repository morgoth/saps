class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  validates_presence_of :content
  validates_presence_of :user_id
end