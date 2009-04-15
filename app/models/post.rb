class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  default_scope :order => 'created_at DESC'

  validates_presence_of :content, :title
end
