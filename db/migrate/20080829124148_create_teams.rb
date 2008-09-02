class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :name
			t.integer :points, {:default=>0}
			t.integer :sets_won, {:default=>0}
			t.integer :sets_lost, {:default=>0}
			t.integer :matches_played, {:default=>0}

      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
