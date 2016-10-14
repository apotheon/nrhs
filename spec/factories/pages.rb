FactoryGirl.define do
  factory :page do
    title { FFaker::Lorem.sentence[0...50] }
    body { FFaker::Lorem.paragraphs(3).join("\n").first 1000 }
  end
end
