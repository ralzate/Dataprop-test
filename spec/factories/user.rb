# frozen_string_literal: true

FactoryBot.define do
    factory :user do
        email { 'example@mail.com' }
        password { '12345678' }
    end
end