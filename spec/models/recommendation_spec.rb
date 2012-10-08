require 'spec_helper'

describe Recommendation do

  it "has a valid factory" do
    Factory.create(:recommendation).should be_valid
  end

  it "is invalid without recommender_email" do
    Factory.build(:recommendation, :recommender_email => nil).should_not be_valid
  end
  
  it "is invalid without recommender_social_account_name" do
    Factory.build(:recommendation, :recommender_social_account_name => nil).should_not be_valid
  end

  it "is invalid without recommender_social_account_type" do
    Factory.build(:recommendation, :recommender_social_account_type => nil).should_not be_valid
  end

  it "is invalid without request_text" do
    Factory.build(:recommendation, :request_text => nil).should_not be_valid
  end

  it "is invalid without relation" do
    Factory.build(:recommendation, :relation => nil).should_not be_valid
  end

  it "should set status to pending for new instance" do
    recommendation = Factory.create(:recommendation, :feedback_text => nil)
    recommendation.status.should eq Recommendation::STATUS_PENDING
  end
  
  it "should set status to done if feedback_text is given" do
    recommendation = Factory.create(:recommendation)
    recommendation.status.should eq Recommendation::STATUS_DONE
  end
  
  it "should send notification to existing recommender" do
    recommendee = Factory(:confirmed_user)
    recommender = Factory(:confirmed_user)
    recommendation = Factory.create(:recommendation, :recommendee => recommendee, :recommender => recommender)
    recommendation.notifications.last.should eq recommender.notifications.last
  end
  
  it "should send email to non existing recommender" do
    recommender = Factory(:user)
    recommendee = Factory(:confirmed_user)
    recommendation = Factory(:recommendation)
    recommendation.recommendee =  recommendee
    recommendation.recommender = recommender
    recommendation.save(:validate => false)

    NotificationMailer.send_recommendation_invitation(recommender.email, nil).deliver
    ActionMailer::Base.deliveries.last.to.should == [recommender.email]
  end
  
end
