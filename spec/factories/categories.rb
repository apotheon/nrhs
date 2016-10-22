FactoryGirl.define do
  factory :category do
    name { FFaker::Lorem.sentence[0...30].strip }
  end
end
