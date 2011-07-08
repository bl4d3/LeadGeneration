class Argument < ActiveRecord::Base
  has_many :posts
  
  # VALIDATIONS
	validates :name, :presence => true
	
	def to_param  # overridden
    "#{id}-#{name.parameterize}"
  end
end
