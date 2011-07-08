class Company < ActiveRecord::Base

  attr_accessor :city_name
  attr_reader :city_name
  attr_reader :department_tokens
  attr_accessor :privacy
	# ASSOCIATIONS
	belongs_to :city
	belongs_to :department
	
	has_many :zones, :dependent => :destroy
	accepts_nested_attributes_for :zones, :allow_destroy => true
	
	has_many :zones
  has_many :departments, :through => :zones
	
	has_many :services
  has_many :categories, :through => :services
  
  has_many :delivers
  has_many :estimates, :through => :delivers
  
  def city_name
    self.city.name unless city.blank?
  end
  

  def department_tokens=(ids)
    self.department_ids = ids.split(",")
  end  
	
	# VALIDATIONS
	validates :name, :presence => true
	validates :city_id, :presence => true
	validates :address, :presence => true
	validates :privacy, :format => /1/
	validates :email_address, :presence => true, :uniqueness => true, :email_format => true
	
	def self.all(user)
	  if user.role?(:admin)
	    order("created_at DESC")
    else
      where(:user_id => user.id).order("created_at DESC")
    end
  end
  
  def self.calculate(max, category, department)
    
    @companies = []
    check = true
    rank = category.companies.joins(:zones).where(:is_enabled => 1, :zones => {:department_id => department.id}).minimum(:rank)
    
    while check
      
      @candidates = category.companies.joins(:zones).where(:is_enabled => 1, :zones => {:department_id => department.id}).where(:rank => rank)
      
      if @candidates.blank?
        check = false
      else
        @candidates.each do |candidate|
          if @companies.size < max
            @companies << candidate
          end
        end
        
        if @companies.size < max
          check = true
          rank = rank.to_i + 1
        else
          check = false
        end
      end
    end
    
    return @companies
  end
	
	def to_param  # overridden
    "#{id}-#{name.parameterize}"
  end	
end
