require 'spec_helper'

describe Notification do

  it "has a valid factory" do
    Factory.create(:notification).should be_valid
  end

  it "set status as unread for new object" do
    Factory.create(:notification).status.should eq(Notification::STATUS_UNREAD)
  end
  
end