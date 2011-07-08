class AddDisplayNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :displayName, :string
  end

  def self.down
    remove_column :users, :displayName
  end
end
