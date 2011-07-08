class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.text :intro
      t.text :body
      t.text :mkey
      t.text :mdescription
      t.string :slug
      t.integer :argument_id
      t.integer :user_id
      t.boolean :is_public
      t.boolean :is_commentable

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
