class SplitNameInPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :first_name, :string
    add_column :players, :last_name, :string
    Player.reset_column_information
    Player.all.each do |player|
      player.first_name, player.last_name = player.name.split(" ")
      player.save
    end
    remove_column :players, :name
  end

  def self.down
    add_column :players, :name, :string
    Player.reset_column_information
    Player.all.each do |player|
      player.name = player.first_name.to_s + player.last_name.to_s
      player.save
    end
    remove_column :players, :first_name
    remove_column :players, :last_name
  end
end
