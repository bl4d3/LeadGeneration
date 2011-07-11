class AddMdescriptionToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :mdescription, :text
  end

  def self.down
    remove_column :categories, :mdescription
  end
end
