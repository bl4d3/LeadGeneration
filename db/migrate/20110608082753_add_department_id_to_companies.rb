class AddDepartmentIdToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :department_id, :integer
  end

  def self.down
    remove_column :companies, :department_id
  end
end
