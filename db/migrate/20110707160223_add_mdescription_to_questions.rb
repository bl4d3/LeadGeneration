class AddMdescriptionToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :mdescription, :text
  end

  def self.down
    remove_column :questions, :mdescription
  end
end
