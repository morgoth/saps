class CreateAchievements < ActiveRecord::Migration
  def self.up
    create_table :achievements do |t|
      t.date :played_at
      t.string :photo_url
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :achievements
  end
end
