class AddInfoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :info, :text
  end

  def self.down
    remove_column :users, :info
  end
end
