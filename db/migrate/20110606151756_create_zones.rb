class CreateZones < ActiveRecord::Migration
  def self.up
    create_table :zones do |t|
      t.integer :city_id
      t.integer :department_id
      t.integer :company_id

      t.timestamps
    end
  end

  def self.down
    drop_table :zones
  end
end
