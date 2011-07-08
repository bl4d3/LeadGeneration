class AddIsEnabledToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :is_enabled, :boolean, :default => 0
  end

  def self.down
    remove_column :companies, :is_enabled
  end
end
