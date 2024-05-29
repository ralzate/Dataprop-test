# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

def random_decimal(min, max)
    rand * (max - min) + min
end

def random_integer(min, max)
    rand(min..max)
end

def random_latitude_longitude
    { latitude: random_decimal(-34.8, -34.5), longitude: random_decimal(-58.5, -58.3) }
end

100.times do
    Property.create(
        property_type: ["rent", "sale"].sample,
        price: random_integer(100000, 500000),
        currency: ["USD", "CLP"].sample,
        address: Faker::Address.full_address,
        area: random_decimal(50, 300),
        bedrooms: random_integer(1, 5),
        bathrooms: random_integer(1, 3),
        **random_latitude_longitude,
        description: Faker::Lorem.paragraph(sentence_count: 3),
        user_id: random_integer(1, 10),
        district: District.all.sample
    )
end
