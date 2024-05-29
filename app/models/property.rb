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

  def fetch_dollar_value
    response = HTTParty.get('https://mindicador.cl/api')
    
    if response.success?
      response.parsed_response['dolar']['valor'].to_f
    else
      raise StandardError, "Error al obtener el valor del dólar desde Mindicador.cl: #{response.code}"
    end
  end
  
  def usd_to_clp
    dollar_value = fetch_dollar_value

    (price.to_f * dollar_value).round(2)
  end
  
  def clp_to_usd
    dollar_value = fetch_dollar_value
    dollar_conversion_rate = (1 / dollar_value)
    
    (price.to_f * dollar_conversion_rate).round(2)
  end

  def converted_price
    if currency == 'USD'
      { amount: usd_to_clp, currency: 'CLP' }
    elsif currency == 'CLP'
      { amount: clp_to_usd, currency: 'USD' }
    else
      { amount: price, currency: currency }
    end
  end
end