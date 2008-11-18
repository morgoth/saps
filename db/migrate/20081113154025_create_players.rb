class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.string :name
      t.date :birth_date
      t.integer :height
      t.string :position
      t.text :about
      t.boolean :active_player

      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
