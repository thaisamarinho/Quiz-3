FactoryGirl.define do
  factory :comment do
    association :user, factory: :user
    association :idea, factory: :idea

    body {Faker::Lorem.paragraph}
  end
end
