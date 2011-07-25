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
	validates :email, :presence => true, :email_format => true
	validates :phone, :presence => true
	validates :privacy, :format => /1/

  def calculate_categories
    companies = []
    categories.each do |category|
      Company.calculate(ESTIMATE_FOR_COMPANY, category, city.department).each do |company|
         
        unless companies.include?(company)
            companies << company
            # update the rank
            company.update_attribute(:rank, company.rank+1)
            # keep trace of delivered emails...
            Deliver.create(:estimate_id => id, :company_id => company.id, :is_delivered => false)
        end
      end
    end
    return companies
  end
	
end
