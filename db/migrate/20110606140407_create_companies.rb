class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.float :latitude
      t.float :longitude
      t.float :altitude
      t.string :name
      t.text :description
      t.string :piva
      t.string :url_site
      t.string :email_address
      t.string :phone
      t.string :fax
      t.string :timetable
      t.string :facebook
      t.string :twitter
      t.string :youtube
      t.integer :tokens
      t.boolean :is_exclusive
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
