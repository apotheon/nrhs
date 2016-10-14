FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    password 'password'
  end

  trait :admin do
    after :create do |user|
      user.admin = true
      user.save!
    end
  end
end
