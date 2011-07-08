class AddCityIdToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :city_id, :integer
  end

  def self.down
    remove_column :companies, :city_id
  end
end
