Factory.define :league do |f|
  f.sequence(:name) { |n| "league#{n}" }
  f.three_zero 3
  f.three_two 2
  f.zero_three 0
  f.two_three 1
  f.active false
end
