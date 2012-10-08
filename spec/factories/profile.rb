Factory.define(:profile, :class => Profile) do |f|
  f.sequence(:display_name) { |n| "display_name#{n}"}
  f.sequence(:about_me){|n| "about#{n} me #{n}"}
end