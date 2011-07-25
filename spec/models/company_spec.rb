require 'spec_helper'

describe Company do
  
  before(:each) do
    @company = Factory(:company)
  end
  
  describe "validations" do

    it "valid name" do
      c = Factory.build(:company, :name => nil)
      c.should_not be_valid
      c.should have(1).error_on(:name)
      c.name = Factory.next(:name)
      c.should have(0).error_on(:name)
    end
  
    it "valid address" do
      c = Factory.build(:company, :address => nil)
      c.should_not be_valid
      c.should have(1).error_on(:address)
      c.address = Factory.next(:address)
      c.should have(0).error_on(:address)
    end
  
    it "valid city" do
      c = Factory.build(:company, :city_id => nil)
      c.should_not be_valid
      c.should have(1).error_on(:city_id)
      c.city_id = 1
      c.should have(0).error_on(:city_id)
    end
  
    it "valid privacy" do
      c = Factory.build(:company, :privacy => nil)
      c.should_not be_valid
      c.should have(1).error_on(:privacy)
      c.privacy = 1
      c.should have(0).error_on(:privacy)
    end
  
    it "has invalid email" do
      c = Factory.build(:company, :email_address => nil)
      c.should_not be_valid
      c.should have(2).error_on(:email_address)
    end
  
    it "has invalid email format" do
      c = Factory.build(:company, :email_address => "invalid_email")
      c.should_not be_valid
      c.should have(1).error_on(:email_address)
    end
  
    it "has unique email" do
      c = Factory.build(:company, :email_address => @company.email_address)
      c.should_not be_valid
      c.should have(1).error_on(:email_address)
      c.email_address = "unique@gmail.com"
      c.should have(0).error_on(:email_address)
    end
  
    it "has a valid url site" do
      c = Factory.build(:company)
      c.should have(0).error_on(:url_site)
      c.url_site = "http://facebook.com"
      c.should have(0).error_on(:url_site)
      c.url_site = "http://www.facebook.com"
      c.should have(0).error_on(:url_site)
    end
  
    it "has an invalid url site" do
      c = Factory.build(:company, :url_site => "foo")
      c.should have(1).error_on(:url_site)
    end
    
    it "has a valid facebook page" do
      c = Factory.build(:company)
      c.should have(0).error_on(:url_site)
      c.url_site = "http://facebook.com"
      c.should have(0).error_on(:url_site)
      c.url_site = "http://www.facebook.com"
      c.should have(0).error_on(:url_site)
    end
  
    it "has an invalid facebook page" do
      c = Factory.build(:company, :url_site => "foo")
      c.should have(1).error_on(:url_site)
    end
  
    it "has a valid twitter page" do
      c = Factory.build(:company)
      c.should have(0).error_on(:url_site)
      c.url_site = "http://facebook.com"
      c.should have(0).error_on(:url_site)
      c.url_site = "http://www.facebook.com"
      c.should have(0).error_on(:url_site)
    end
  
    it "has an invalid twitter page" do
      c = Factory.build(:company, :url_site => "foo")
      c.should have(1).error_on(:url_site)
    end
  
    it "has a valid youtube page" do
      c = Factory.build(:company)
      c.should have(0).error_on(:url_site)
      c.url_site = "http://facebook.com"
      c.should have(0).error_on(:url_site)
      c.url_site = "http://www.facebook.com"
      c.should have(0).error_on(:url_site)
    end
  
    it "has an invalid youtube page" do
      c = Factory.build(:company, :url_site => "foo")
      c.should have(1).error_on(:url_site)
    end
    
    it "has a full address" do
      city = Factory.build(:city, :name => "demo-city")
      c = Factory.build(:company, :address => "address", :city => city)
      c.full_address.should include("address") 
      c.full_address.should include("demo-city") 
    end

    it "has a city name" do
      city = Factory.build(:city, :name => "demo-city")
      c = Factory.build(:company, :city => city)
      c.city_name.should include("demo-city")
    end
    
  end
  
  describe "relationships" do
    
    it {should belong_to(:city)}
    it {should have_many(:categories)}
    it {should have_many(:departments)}
    
    it "belongs to city" do
      city = Factory.build(:city)
      c = Factory.build(:company, :city => city)
    end

    it "has many categories" do
      @company.categories.size.should == 0
      category = Factory.build(:category)
      @company.categories << category
      @company.categories.size.should == 1
    end

    it "has maximum 4 categories" do
      5.times do
        category = Factory.build(:category)
        @company.categories << category      
      end
      @company.should have(1).error_on(:category_ids)
    end

    it "has many departments" do
      @company.departments.size.should == 0
      department = Factory.build(:department)
      @company.departments << department
      @company.departments.size.should == 1
    end

    it "has maximum 4 department" do
      5.times do
        department = Factory.build(:department)
        @company.departments << department      
      end
      @company.should have(1).error_on(:department_ids)
    end
  
  end
  
  describe "geo" do
    it "is georeferred" do
      c = Factory.build(:company, :latitude => nil, :longitude => nil)
      c.georeferred?.should be_true
      c.latitude = 45.5
      c.longitude = 45.66
      c.georeferred?.should be_false
    end
  end  
end
