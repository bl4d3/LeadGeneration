class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name
      t.string :lastname
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
