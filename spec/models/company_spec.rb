require 'spec_helper'

describe Company do
  
  before do
    @company = Company.new 
  end
  
  it "should be a company" do
    @company.should be_an_instance_of(Company)
  end
end
