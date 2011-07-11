class AddMkeyToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :mkey, :text
  end

  def self.down
    remove_column :categories, :mkey
  end
end
