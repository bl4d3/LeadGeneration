class Position < ActiveRecord::Base

	# ASSOCIATIONS
	belongs_to :container
	belongs_to :place
	
	# VALIDATIONS
	validates :container_id, :presence => true
	validates :place_id, :presence => true
end
