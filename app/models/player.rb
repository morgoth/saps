class Player < ActiveRecord::Base
  POSITIONS = %w{Przyjmujący Atakujący Rozgrywający Środkowy Libero}
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_inclusion_of :position, :in => POSITIONS, :message => "Wrong position", :allow_blank => true
  validates_numericality_of :height, :only_integer => true, :greater_than => 100, :less_than => 230, :allow_nil => true

end
