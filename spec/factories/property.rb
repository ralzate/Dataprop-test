# frozen_string_literal: true

FactoryBot.define do
    factory :property do
        property_type { 'rent' }
        price { 100 }
        currency { 'USD' }
        address { 'Avenida Siempre Viva 742' }
        area { 100 }
        bedrooms { 3 }
        bathrooms { 2 }
        latitude { 0 }
        longitude { 0 }
        description { 'A nice place to live' }
        district
        user
    end
end