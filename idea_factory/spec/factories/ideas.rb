FactoryGirl.define do
  factory :idea do

    association :user, factory: :user

    title {Faker::Lorem.sentence}
    body {Faker::Lorem.paragraph}
  end
end
