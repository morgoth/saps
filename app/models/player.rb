# encoding: UTF-8

class Player < ActiveRecord::Base
  POSITIONS = %w{Przyjmujący Atakujący Rozgrywający Środkowy Libero}

  default_scope :order => "last_name"
  named_scope :active, :conditions => { :active_player => true }
  named_scope :not_active, :conditions => { :active_player => "NOT TRUE" }

  validates_presence_of :first_name, :last_name
  validates_inclusion_of :position, :in => POSITIONS, :allow_blank => true
  validates_numericality_of :height, :only_integer => true, :greater_than => 100, :less_than => 230, :allow_nil => true

  def full_name
    "#{first_name} #{last_name}"
  end
end
