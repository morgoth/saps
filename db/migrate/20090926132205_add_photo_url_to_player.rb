class AddPhotoUrlToPlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :photo_url, :string
    remove_column :players, :photo_file_name
    remove_column :players, :photo_content_type
    remove_column :players, :photo_file_size
    remove_column :players, :photo_updated_at
  end

  def self.down
    remove_column :players, :photo_url
    add_column :players, :photo_file_name, :string
    add_column :players, :photo_content_type, :string
    add_column :players, :photo_file_size, :integer
    add_column :players, :photo_updated_at, :datetime
  end
end
