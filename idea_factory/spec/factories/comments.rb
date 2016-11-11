FactoryGirl.define do
  factory :comment do
    user
    idea
    body {Faker::Lorem.paragraph}
  end
end
