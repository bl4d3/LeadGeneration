class AddHitToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :hit, :integer
  end

  def self.down
    remove_column :questions, :hit
  end
end
