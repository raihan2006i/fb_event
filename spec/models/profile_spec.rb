require 'spec_helper'

describe Profile do

  it "has a valid factory" do
    Factory.create(:profile).should be_valid
  end

  it "is invalid without display name" do
    Factory.build(:profile, :display_name => nil).should_not be_valid
  end

  it "is invalid if display name atleast three words" do
    Factory.build(:profile, :about_me => "display name").should be_invalid
  end
  
end