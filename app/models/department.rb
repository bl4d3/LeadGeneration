class Department < ActiveRecord::Base

	# ASSOCIATIONS
	has_many :companies
	has_many :cities
	belongs_to :zone
	
	has_many :zones
  has_many :companies, :through => :zones	
	
	# VALIDATIONS
	validates :name, :presence => true	
end
