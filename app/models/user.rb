class User < ActiveRecord::Base
  has_many :posts, :dependent => :nullify

  validates_presence_of :login, :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => Authlogic::Regex.email

  acts_as_authentic do |c|
    c.act_like_restful_authentication = true
  end

  attr_accessible :login, :email, :password, :password_confirmation

  def self.find_by_username_or_email(login)
    find_by_smart_case_login_field(login) || find_by_smart_case_email_field(login)
  end

  def self.find_by_smart_case_email_field(email)
    where(["LOWER(#{quoted_table_name}.#{email_field}) = ?", email.downcase]).first if email
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.password_reset_instructions(self).deliver
  end
end
