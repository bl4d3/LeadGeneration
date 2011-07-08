class AddIsEnabledToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :is_enabled, :boolean
  end

  def self.down
    remove_column :questions, :is_enabled
  end
end
