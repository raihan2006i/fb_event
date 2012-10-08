#require 'spec_helper'
#
#describe "recommendations/show" do
#  before(:each) do
#    @recommendation = assign(:recommendation, stub_model(Recommendation,
#      :recommender_social_account_name => "Recommender Social Account Name",
#      :recommender_social_account_type => "Recommender Social Account Type",
#      :request_text => "MyText",
#      :feedback_text => "MyText"
#    ))
#  end
#
#  it "renders attributes in <p>" do
#    render
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    rendered.should match(/Recommender Social Account Name/)
#    rendered.should match(/Recommender Social Account Type/)
#    rendered.should match(/MyText/)
#    rendered.should match(/MyText/)
#  end
#end
