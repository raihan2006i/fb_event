Factory.define(:social_account, :class => SocialAccount) do |f|
  f.sequence(:account_name) { |n| "account_name#{n}"}
  f.account_type 1
end