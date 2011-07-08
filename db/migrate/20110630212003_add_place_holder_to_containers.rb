class AddPlaceHolderToContainers < ActiveRecord::Migration
  def self.up
    add_column :containers, :place_holder, :string
  end

  def self.down
    remove_column :containers, :place_holder
  end
end
