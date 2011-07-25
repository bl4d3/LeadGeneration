require 'spec_helper'

describe Department do
  
  before(:each) do
    @department = Factory(:department)
  end
  
  describe "validations" do
    it "valid name" do
      d = Factory.build(:department, :name => nil)
      d.should have(1).error_on(:name)
      d.name = "demo-city"
      d.should have(0).error_on(:name)
    end
  end
  
  describe "relationships" do
    
    it {should have_many(:cities)}
    it {should have_many(:companies)}
    
    it "has many companies" do
      c = Factory(:company)
      @department.companies << c
      @department.save
      @department.companies.size.should == 1
      @department.companies.first.should == c
    end
    
    it "has many cities" do
      c = Factory(:city)
      @department.cities << c
      @department.save
      @department.cities.size.should == 1
      @department.cities.first.should == c
    end
    
  end
  
end