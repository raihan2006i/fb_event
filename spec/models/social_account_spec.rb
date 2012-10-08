require 'spec_helper'

describe SocialAccount do

  it "has a valid factory" do
    SocialAccount.any_instance.stub(:must_be_valid_account).and_return(true)
    Factory.create(:social_account).should be_valid
  end

  it "is invalid without account_name" do
    Factory.build(:social_account, :account_name => "linkedin").should_not be_valid
  end

  it "is invalid without account_type" do
    Factory.build(:social_account, :account_type => nil).should_not be_valid
  end

end
