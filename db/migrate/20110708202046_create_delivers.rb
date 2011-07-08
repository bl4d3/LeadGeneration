class CreateDelivers < ActiveRecord::Migration
  def self.up
    create_table :delivers do |t|
      t.integer :company_id
      t.integer :estimate_id
      t.boolean :is_delivered
      t.text :feedback

      t.timestamps
    end
  end

  def self.down
    drop_table :delivers
  end
end
