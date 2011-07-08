class AddNoteToEstimates < ActiveRecord::Migration
  def self.up
    add_column :estimates, :note, :text
  end

  def self.down
    remove_column :estimates, :note
  end
end
