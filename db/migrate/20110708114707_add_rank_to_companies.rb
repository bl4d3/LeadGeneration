class AddRankToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :rank, :integer, :default => 0
  end

  def self.down
    remove_column :companies, :rank
  end
end
