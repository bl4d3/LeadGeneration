class Estimate < ActiveRecord::Base
  attr_accessor :city_name
  attr_reader :city_name
  attr_accessor :privacy
  # ASSOCIATIONS
	belongs_to :city
	
	has_many :needs
  has_many :categories, :through => :needs
  
  has_many :delivers
  has_many :companies, :through => :delivers
	
	def city_name
    self.city.name unless city.blank?
  end
  
  # VALIDATIONS
	validates :name, :presence => true
	validates :lastname, :presence => true
	validates :city_id, :presence => true
	validates :address, :presence => true
	validates :email, :presence => true
	validates :phone, :presence => true
	validates :privacy, :format => /1/
	
end
