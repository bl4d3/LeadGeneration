class CreateNeeds < ActiveRecord::Migration
  def self.up
    create_table :needs do |t|
      t.integer :category_id
      t.integer :estimate_id

      t.timestamps
    end
  end

  def self.down
    drop_table :needs
  end
end
