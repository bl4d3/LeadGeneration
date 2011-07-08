class AddProviderNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :providerName, :string
  end

  def self.down
    remove_column :users, :providerName
  end
end
