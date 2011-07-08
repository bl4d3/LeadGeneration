class City < ActiveRecord::Base
	
	# ASSOCIATIONS
	has_many :companies
	belongs_to :zone
	belongs_to :department
	
	# VALIDATIONS
	validates :name, :presence => true
end
