class AddHitToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :hit, :integer
  end

  def self.down
    remove_column :posts, :hit
  end
end
