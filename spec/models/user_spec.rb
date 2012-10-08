require 'spec_helper'

describe User do

  it "has a valid factory" do
    Factory.create(:user).should be_valid
  end

  it "is invalid without username" do
    Factory.build(:user, :username => nil).should_not be_valid
  end

  it "is invalid if username is not unique" do
    Factory.create(:user, :username => "not_unique")
    Factory.build(:user, :username => "not_unique").should be_invalid
  end

  it "should have a profile after create" do
    user = Factory.create(:user)
    user.profile.should be_a(Profile)
  end
  
end