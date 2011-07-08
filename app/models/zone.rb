class Zone < ActiveRecord::Base

	# ASSOCIATIONS
	belongs_to :city
	belongs_to :department
	belongs_to :company
	
	# VALIDATIONS
	validates :department_id, :presence => true
	validates :company_id, :presence => true
end
