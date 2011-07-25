require 'spec_helper'

describe City do
  
  before(:each) do
    @city = Factory(:city)
  end
  
  describe "validations" do
    it "valid name" do
      c = Factory.build(:city, :name => nil)
      c.should have(1).error_on(:name)
      c.name = "demo-city"
      c.should have(0).error_on(:name)
    end
  end
  
  describe "relationships" do
    
    it {should belong_to(:department)}
    it {should have_many(:companies)}
    
    it "belongs to department" do
      d = Factory.build(:department)
      c = Factory.build(:city, :department => d)
      c.department == d
    end
    
    it "has many companies" do
      
      #c = Factory(:company)
      c = Company.new
      @city.companies << c
      @city.save
      @city.companies.size.should == 1
      @city.companies.first.should == c
    end
  end
  
end