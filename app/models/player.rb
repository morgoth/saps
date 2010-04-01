# encoding: UTF-8

class Player < ActiveRecord::Base
  POSITIONS = %w{hitter attacker setter blocker libero}

  default_scope :order => "last_name"
  named_scope :active, :conditions => { :active_player => true }
  named_scope :not_active, :conditions => "active_player IS NULL or active_player = 'f'"

  validates_presence_of :first_name, :last_name
  validates_inclusion_of :position, :in => POSITIONS, :allow_blank => true
  validates_numericality_of :height, :only_integer => true, :greater_than => 100, :less_than => 230, :allow_nil => true

  def full_name
    "#{first_name} #{last_name}"
  end

  def position_name
    I18n::translate("position.#{position}")
  end
end
