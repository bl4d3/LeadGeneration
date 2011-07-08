class AddMkeyToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :mkey, :text
  end

  def self.down
    remove_column :questions, :mkey
  end
end
