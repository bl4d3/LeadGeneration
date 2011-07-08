class Post < ActiveRecord::Base
  
  acts_as_commentable
  
  belongs_to :argument
  belongs_to :user
  
	def self.all(user)
	  if user.role?(:admin)
	    order("created_at DESC")
    else
      where(:user_id => user.id).order("created_at DESC")
    end
  end
  
  # VALIDATIONS
	validates :title, :presence => true
	#validates :argument_id, :presence => true
	
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
