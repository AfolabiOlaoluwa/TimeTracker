# frozen_string_literal: true

FactoryBot.define do
  factory :clock_entry do
    user
    purpose { Faker::Lorem.sentence }
  end
end