FactoryGirl.define do
  factory :page do
    title { FFaker::Lorem.sentence[0...30].strip }
    body { FFaker::Lorem.paragraphs(3).join("\n").first 1000 }
    category { Category.create! }
  end
end
