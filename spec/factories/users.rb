# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    email { 'john@example.com' }
    phone { '1234567890' }
    password { 'password123' }
    role { 'customer' }
  end
end
