class AddCodeToDepartments < ActiveRecord::Migration
  def self.up
    add_column :departments, :code, :integer
  end

  def self.down
    remove_column :departments, :code
  end
end
