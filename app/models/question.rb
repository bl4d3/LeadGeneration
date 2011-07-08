class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  acts_as_commentable  
  
  # VALIDATIONS
	#validates :email, :presence => true, :email_format => true
	validates :title, :presence => true
	validates :body, :presence => true
	
	def hit_one
	  if self.hit.blank?
	    update_attribute(:hit, 1)
	  else
	    update_attribute(:hit, hit.to_i+1)
	  end
  end
	
	def to_param  # overridden
    "#{id}-#{title.parameterize}"
  end
  
end
