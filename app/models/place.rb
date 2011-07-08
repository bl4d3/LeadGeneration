class Place < ActiveRecord::Base

	#ASSOCIATIONS
	has_many :positions
	has_many :containers, :through => :positions
	
	# VALIDATIONS
	validates :name, :presence => true
	validates :alias, :presence => true
end
