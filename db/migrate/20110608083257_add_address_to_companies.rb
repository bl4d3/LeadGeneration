class AddAddressToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :address, :string
  end

  def self.down
    remove_column :companies, :address
  end
end
