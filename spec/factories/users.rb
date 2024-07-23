FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    sequence(:email) { |n| "test#{n}@example.com" }
    phone { '+380000000000' }
    password { 'Password123!' }
    password_confirmation { "Password123!" }
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end
