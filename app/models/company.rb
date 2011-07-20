class Company < ActiveRecord::Base

  acts_as_gmappable :process_geocoding => false

  attr_accessor :city_name
  attr_reader :city_name
  attr_reader :department_tokens
  attr_accessor :privacy
  attr_accessor :full_address  
  attr_reader :full_address  
	# ASSOCIATIONS
	belongs_to :city
	belongs_to :department
	belongs_to :user
	
	has_many :zones, :dependent => :destroy
	accepts_nested_attributes_for :zones, :allow_destroy => true
	
	has_many :zones
  has_many :departments, :through => :zones
	
	has_many :services
  has_many :categories, :through => :services
  
  has_many :delivers
  has_many :estimates, :through => :delivers

  # GEOCODING
  geocoded_by :full_address
  after_validation :geocode, :if => :georeferred?
  
  def georeferred?
    self.latitude.blank? || self.longitude.blank?
  end

  def full_address
    unless city.blank?
      "#{self.address}, #{self.city.name}"
    end
  end
  
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
	validates :url_site, :uri => { :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix }, :if => Proc.new{|a| a.url_site.present? }
	validates :facebook, :uri => { :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix }, :if => Proc.new{|a| a.facebook.present? }
	validates :twitter, :uri => { :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix }, :if => Proc.new{|a| a.twitter.present? }
	validates :youtube, :uri => { :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix }, :if => Proc.new{|a| a.youtube.present? }
	before_validation :check_categories
	before_validation :check_departments
	
	# geomap4rails
	
	 def gmaps4rails_address
     self.address #describe how to retrieve the address from your model
   end
     
   def gmaps4rails_infowindow
     r = ""
     r += name.gsub(/[^0-9a-z ]/i, '')
 		 r += "<br />#{address.parameterize(' ')}, #{city.name}" if !address.blank? || !city_id.blank?
 		 r += "<br />Aree di compenteza: #{categories.map(&:title).join(', ')}" unless categories.blank?
     	 
     "#{r}<br/><a href='javascript:void(0);' onClick='bangme(#{id});'>Visualizza dettagli</a>"
    end
   
   #when mouse going hover 
   def gmaps4rails_title
     "#{name}"
   end
   
	def gmaps4rails_marker_picture
		path = "/images/"
		img = path + "point.png"
	
     {
      "picture" => img,
      "width" => "32",
      "height" => "32"
     }
	end
	#
	
	# check max numbers of categories
	def check_categories
	  if self.categories.size > MAX_CATEGORIES_FOR_COMAPNY
	    errors.add(:category_ids, "Selezionare al massimo #{MAX_CATEGORIES_FOR_COMAPNY} categorie")
    end
	end
	
	# check max numbers of departments
	def check_departments
	  if self.departments.size > MAX_DEPARTMENTS_FOR_COMAPNY
	    errors.add(:department_ids, "Selezionare al massimo #{MAX_DEPARTMENTS_FOR_COMAPNY} provincie")
    end	 
	end
	
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
    rank_array = category.companies.joins(:zones).where(:is_enabled => 1, :zones => {:department_id => department.id}).order(:rank).map(&:rank).uniq
    
    index = 0
    rank = rank_array[index]
    
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
        
        if @companies.size < max && index < rank_array.size 
          check = true
          index += 1
          rank = rank_array[index]
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
