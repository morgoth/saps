class TeamTables < ActiveRecord::Migration
  def self.up
      create_table :team_tables do |t|
        t.integer :league_id
        t.integer :team_id
        t.integer :points, {:default=>0}
        t.integer :sets_won, {:default=>0}
        t.integer :sets_lost, {:default=>0}
        t.integer :matches_played, {:default=>0}
      end
  end

  def self.down
    drop_table :team_tables
  end
end
