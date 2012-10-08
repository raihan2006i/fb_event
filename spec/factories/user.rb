Factory.define(:user, :class => User) do |f|
  f.sequence(:email) { |n| "test#{n}@nascenia.com"}
  f.sequence(:username){|n| "test#{n}"}
  f.password "testpass"
end

Factory.define :confirmed_user, :parent => :user do |f|
  f.after_create { |user| user.confirm! }
end