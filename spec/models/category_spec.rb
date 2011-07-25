require 'spec_helper'

describe Category do
  
  before(:each) do
    @category = Factory(:category)
  end
  
  describe "validations" do
    it "has a valid title"  do
      c = Factory.build(:category, :title => nil)
      c.should have(1).error_on(:title)
      c.title = "demo-category"
      c.should have(0).error_on(:title)
    end
  end
  
  describe "relationships" do
    it "has many companies" do
      c = Factory(:company)
      @category.companies << c
      @category.save
      @category.should have_many(:companies)
      @category.companies.size.should == 1
      @category.companies.first.should == c
    end
  end
  
  describe "acts_as_tree" do 
    it "has children" do
      child = Factory(:category, :parent_id => @category.id)
      @category.children.size.should == 1
      @category.children.first == child
      child.root.should == @category
    end
  end
  
end