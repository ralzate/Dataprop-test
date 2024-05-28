require 'httparty'

class Property < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  belongs_to :district

  enum property_type: { rent: 'rent', sale: 'sale' }, _suffix: true
  enum currency: { USD: 'USD', CLP: 'CLP' }, _prefix: true

  validates :property_type, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :currency, presence: true, inclusion: { in: currencies.keys }
  validates :address, presence: true
  validates :area, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :bedrooms, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :bathrooms, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: true
  validates :description, presence: true

  def self.property_types_for_select
    property_types.keys.map { |type| [type.humanize, type] }
  end

  def self.currencies_for_select
    currencies.keys.map { |currency| [currency, currency] }
  end

  def self.usd_to_cop
    response = HTTParty.get('https://api.exchangerate-api.com/v4/latest/USD')
    dolar_value = response.parsed_response['rates']['COP']  # Obtenemos el valor del dólar en pesos colombianos
    dolar_value.to_f
  end

  def self.cop_to_usd
    response = HTTParty.get('https://api.exchangerate-api.com/v4/latest/COP')
    dolar_value = response.parsed_response['rates']['USD']  # Obtenemos el valor del peso colombiano en dólares
    dolar_value.to_f
  end

  def converted_price
    if currency == 'USD'
      { amount: (price.to_f * self.class.usd_to_cop).round(2), currency: 'COP' }
    elsif currency == 'COP'
      { amount: (price.to_f * self.class.cop_to_usd).round(2), currency: 'USD' }
    else
      { amount: price, currency: currency }
    end
  end
end