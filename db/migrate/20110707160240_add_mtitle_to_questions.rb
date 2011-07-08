class AddMtitleToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :mtitle, :text
  end

  def self.down
    remove_column :questions, :mtitle
  end
end
