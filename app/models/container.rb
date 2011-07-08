class Container < ActiveRecord::Base
	acts_as_tree :order => "name"

	has_many :positions
	has_many :places, :through => :positions
	
	validates :name, :presence => true
	
  def to_param  # overridden
    slug.blank? ? "#{id}-#{name.parameterize}" : "#{id}-#{slug.parameterize}"
  end	
end
