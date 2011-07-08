class Deliver < ActiveRecord::Base
  belongs_to :estimate
  belongs_to :company
end
