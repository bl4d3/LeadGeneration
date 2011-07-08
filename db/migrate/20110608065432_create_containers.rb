class CreateContainers < ActiveRecord::Migration
  def self.up
    create_table :containers do |t|
      t.string :name
      t.text :description
      t.integer :parent_id
      t.integer :is_public
      t.integer :order_show
      t.string :template
      t.integer :user_id
      t.string :mkey
      t.string :mdescription
      t.string :mtitle
      t.string :slug

      t.timestamps
    end
  end

  def self.down
    drop_table :containers
  end
end
