class AddUsersPasswordResetFields < ActiveRecord::Migration
  def self.up
    add_column :users, :perishable_token, :string, :default => "", :null => false
    add_column :users, :email, :string
 end

  def self.down
    remove_column :users, :perishable_token
    remove_column :users, :email
  end
end
