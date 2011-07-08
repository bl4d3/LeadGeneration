class AddSubTitleToContainers < ActiveRecord::Migration
  def self.up
    add_column :containers, :sub_title, :string
  end

  def self.down
    remove_column :containers, :sub_title
  end
end
