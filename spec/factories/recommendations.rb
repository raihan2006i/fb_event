# Read about factories at https://github.com/thoughtbot/factory_girl

Factory.define(:recommendation, :class => Recommendation) do |f|
  f.sequence(:recommender_social_account_name) { |n| "facebook#{n}"}
  f.recommender_social_account_type SocialAccount::TYPE_FACEBOOK
  f.sequence(:recommender_email) { |n| "recommender#{n}@example.com"}
  f.relation Recommendation::EMPLOYEE
  f.sequence(:request_text){|n| "request#{n}"}
  f.sequence(:feedback_text){|n| "feedback#{n}"}
end