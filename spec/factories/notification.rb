# frozen_string_literal: true

# spec/factories/notifications.rb
FactoryBot.define do
  factory :notification do
    association :user
    message { Faker::Lorem.sentence }
    status { true } # or false, depending on your needs

    # Add any other attributes or associations specific to your model

    trait :read do
      status { true }
    end

    trait :unread do
      status { false }
    end
  end
end
