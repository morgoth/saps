class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.integer :home_team_id
      t.integer :visitor_team_id
      t.datetime :hour
      t.string :score
      t.integer :round_id

      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end
