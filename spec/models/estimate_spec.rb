require 'spec_helper'

describe Estimate do
  
  before(:each) do
    @estimate = Factory(:estimate)
  end
  
  describe "validations" do
    it "valid name" do
      e = Factory.build(:estimate, :name => nil)
      e.should have(1).error_on(:name)
      e.name = "estimate"
      e.should have(0).error_on(:name)
    end
    
    it "valid lastname" do
      e = Factory.build(:estimate, :lastname => nil)
      e.should have(1).error_on(:lastname)
      e.lastname = "estimate"
      e.should have(0).error_on(:lastname)
    end
    
    it "valid city" do
      c = Factory(:city)
      e = Factory.build(:estimate, :city => nil)
      e.should have(1).error_on(:city_id)
      e.city = c
      e.should have(0).error_on(:city_id)
    end
    
    it "has valid email" do
      e = Factory.build(:estimate, :email => nil)
      e.should_not be_valid
      e.should have(2).error_on(:email)
      e.email = "invalid_email"
      e.should_not be_valid
      e.should have(1).error_on(:email)
      e.email = @estimate.email
      e.should be_valid
      e.should have(0).error_on(:email)
    end
    
  
    it "valid privacy" do
      e = Factory.build(:estimate, :privacy => nil)
      e.should_not be_valid
      e.should have(1).error_on(:privacy)
      e.privacy = 1
      e.should have(0).error_on(:privacy)
    end
    
    it "valid address" do
      e = Factory.build(:estimate, :address => nil)
      e.should have(1).error_on(:address)
      e.address = "address"
      e.should have(0).error_on(:address)
    end
    
    it "valid phone" do
      e = Factory.build(:estimate, :phone => nil)
      e.should have(1).error_on(:phone)
      e.phone = "1234"
      e.should have(0).error_on(:phone)
    end
  end
  
  describe "relationships" do
    
    it {should have_many(:categories)}
    it {should have_many(:companies)}
    it {should belong_to(:city)}
    
    it "belongs to city" do
      c = Factory(:city)
      e = Factory.build(:estimate, :city => c)
      e.city.should == c
    end
    
    it "has many companies" do
      c = Factory(:company)
      @estimate.companies << c
      @estimate.save
      @estimate.companies.size.should == 1
      @estimate.companies.first.should == c
    end
    
    it "has many categories" do
      c = Factory(:category)
      @estimate.categories << c
      @estimate.save
      @estimate.categories.size.should == 1
      @estimate.categories.first.should == c
    end
  end
end