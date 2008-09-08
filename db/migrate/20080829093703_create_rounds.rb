class CreateRounds < ActiveRecord::Migration
  def self.up
    create_table :rounds do |t|
      t.string :name
      t.date :date
      t.integer :league_id

      t.timestamps
    end
  end

  def self.down
    drop_table :rounds
  end
end
