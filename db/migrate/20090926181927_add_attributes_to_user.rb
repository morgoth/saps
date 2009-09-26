class AddAttributesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :persistence_token, :string
    add_column :users, :login_count, :integer
    add_column :users, :last_request_at, :datetime
    remove_column :users, :email
  end

  def self.down
    remove_column :users, :persistence_token
    remove_column :users, :login_count
    remove_column :users, :last_request_at
    add_column :users, :email, :string
  end
end
