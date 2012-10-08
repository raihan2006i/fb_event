#require 'spec_helper'
#
#describe "recommendations/index" do
#  before(:each) do
#    assign(:recommendations, [
#      stub_model(Recommendation,
#        :recommender_social_account_name => "Recommender Social Account Name",
#        :recommender_social_account_type => "Recommender Social Account Type",
#        :request_text => "MyText",
#        :feedback_text => "MyText"
#      ),
#      stub_model(Recommendation,
#        :recommender_social_account_name => "Recommender Social Account Name",
#        :recommender_social_account_type => "Recommender Social Account Type",
#        :request_text => "MyText",
#        :feedback_text => "MyText"
#      )
#    ])
#  end
#
#  it "renders a list of recommendations" do
#    render
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "tr>td", :text => "Recommender Social Account Name".to_s, :count => 2
#    assert_select "tr>td", :text => "Recommender Social Account Type".to_s, :count => 2
#    assert_select "tr>td", :text => "MyText".to_s, :count => 2
#    assert_select "tr>td", :text => "MyText".to_s, :count => 2
#  end
#end
