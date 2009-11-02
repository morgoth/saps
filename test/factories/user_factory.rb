Factory.define :user do |f|
  f.sequence(:login) { |n| "user#{n}" }
  f.password "secret"
  f.password_confirmation { |u| u.password }
end