class AddMtitleToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :mtitle, :text
  end

  def self.down
    remove_column :categories, :mtitle
  end
end
