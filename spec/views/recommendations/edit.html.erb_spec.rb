#require 'spec_helper'
#
#describe "recommendations/edit" do
#  before(:each) do
#    @recommendation = assign(:recommendation, stub_model(Recommendation,
#      :recommender_social_account_name => "MyString",
#      :recommender_social_account_type => "MyString",
#      :request_text => "MyText",
#      :feedback_text => "MyText"
#    ))
#  end
#
#  it "renders the edit recommendation form" do
#    render
#
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "form", :action => recommendations_path(@recommendation), :method => "post" do
#      assert_select "input#recommendation_recommender_social_account_name", :name => "recommendation[recommender_social_account_name]"
#      assert_select "input#recommendation_recommender_social_account_type", :name => "recommendation[recommender_social_account_type]"
#      assert_select "textarea#recommendation_request_text", :name => "recommendation[request_text]"
#      assert_select "textarea#recommendation_feedback_text", :name => "recommendation[feedback_text]"
#    end
#  end
#end
