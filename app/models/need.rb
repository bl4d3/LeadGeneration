class Need < ActiveRecord::Base
	belongs_to :category
	belongs_to :estimate
end
