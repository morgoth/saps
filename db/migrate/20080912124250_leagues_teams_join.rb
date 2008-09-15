class LeaguesTeamsJoin < ActiveRecord::Migration
  def self.up
      create_table :leagues_teams, :id => false do |t|
        t.integer :league_id
        t.integer :team_id
      end
  end

  def self.down
    drop_table :leagues_teams
  end
end
