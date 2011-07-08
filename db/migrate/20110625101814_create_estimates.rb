class CreateEstimates < ActiveRecord::Migration
  def self.up
    create_table :estimates do |t|
      t.string :name
      t.string :lastname
      t.string :address
      t.integer :city_id
      t.string :email
      t.string :phone

      t.timestamps
    end
  end

  def self.down
    drop_table :estimates
  end
end
