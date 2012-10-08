Factory.define(:notification, :class => Notification) do |f|
  f.sequence(:message) { |n| "message#{n}"}
end