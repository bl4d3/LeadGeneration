class Category < ActiveRecord::Base
	acts_as_tree :order => "title"
	
	# ASSOCIATIONS
	has_many :services
  has_many :companies, :through => :services
  
  has_many :needs
  has_many :estimates, :through => :needs
  
  has_many :questions
	
	# VALIDATIONS
	validates :title, :presence => true	
	
	def self.first_level
		Category.where(:parent_id => nil).order("title asc")
	end
	
	def parent_name
		unless parent.blank?
			parent.title
		end
	end
	
	def self.second_level
		Category.where("parent_id != ?", "").order("title asc")
	end
	
	def to_param  # overridden
    "#{id}-#{title.parameterize}"
  end
	
end
