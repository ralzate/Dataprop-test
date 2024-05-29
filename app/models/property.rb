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

  def self.usd_to_clp
    response = HTTParty.get('https://mindicador.cl/api')
    if response.success?
      dolar_value = response.parsed_response['dolar']['valor'] 
      dolar_value.to_f
    else
      raise StandardError, "Error al obtener el valor del dólar desde Mindicador.cl: #{response.code}"
    end
  end

  def self.clp_to_usd
    response = HTTParty.get('https://mindicador.cl/api')
    if response.success?
      dolar_value = response.parsed_response['dolar']['valor'] 
      (1 / dolar_value.to_f).round(2)
    else
      raise StandardError, "Error al obtener el valor del dólar desde Mindicador.cl: #{response.code}"
    end
  end

  def converted_price
    if currency == 'USD'
      { amount: (price.to_f * self.class.usd_to_clp).round(2), currency: 'CLP' }
    elsif currency == 'COP'
      { amount: (price.to_f * self.class.clp_to_usd).round(2), currency: 'USD' }
    else
      { amount: price, currency: currency }
    end
  end
end