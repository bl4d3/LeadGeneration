class Contact < ActiveRecord::Base
  attr_accessor :privacy
  
  # VALIDATIONS
	validates :email, :presence => true, :uniqueness => true, :email_format => true
	validates :privacy, :format => /1/
end
