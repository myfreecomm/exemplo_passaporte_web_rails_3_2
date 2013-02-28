# encoding: utf-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@example.com" }
  sequence(:uuid) { |n| "some-unique-uuid-#{n}" }

  factory :user do
    email { generate(:email) }
    uuid { generate(:uuid) }
  end
end
