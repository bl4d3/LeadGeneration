class AddVerifiedEmailToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :verifiedEmail, :string
  end

  def self.down
    remove_column :users, :verifiedEmail
  end
end
