class Player < ActiveRecord::Base
	#has_attached_file :photo, :url  => "/images/players_photo/:basename.:extension",
	#																			 :path => ":rails_root/public/images/players_photo/:basename.:extension"
	
	POSITIONS = %w{Przyjmujący Atakujący Rozgrywający Środkowy Libero}
  
	#validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']
	#validates_attachment_size :photo, :less_than => 30.kilobytes
	validates_presence_of :name
	validates_uniqueness_of :name
	validates_inclusion_of :position, :in => POSITIONS, :message => "Wrong position", :unless => :blank_position
	validates_numericality_of :height, :only_integer => true, :greater_than => 100, :less_than => 230, :unless => :blank_height
	
	protected
	def blank_position
		position.blank?
	end
	
	def blank_height
		height.blank?
	end
end
