class AddCoverImageToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :cover_imege, :string
  end

  def self.down
    remove_column :posts, :cover_imege
  end
end
