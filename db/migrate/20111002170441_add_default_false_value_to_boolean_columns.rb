class AddDefaultFalseValueToBooleanColumns < ActiveRecord::Migration
  def up
    change_column :leagues, :active, :boolean, :default => false
    League.reset_column_information
    League.where(:active => nil).update_all(:active => false)

    rename_column :players, :active_player, :active
    change_column :players, :active, :boolean, :default => false
    Player.reset_column_information
    Player.where(:active => nil).update_all(:active => false)
  end

  def down
    rename_column :players, :player, :active_player
  end
end
