class AddAttributesToLeague < ActiveRecord::Migration
  def self.up
    add_column :leagues, :three_zero, :integer
    add_column :leagues, :three_two, :integer
    add_column :leagues, :zero_three, :integer
    add_column :leagues, :two_three, :integer
  end

  def self.down
    remove_column :leagues, :three_zero
    remove_column :leagues, :three_two
    remove_column :leagues, :zero_three
    remove_column :leagues, :zero_two
  end
end
