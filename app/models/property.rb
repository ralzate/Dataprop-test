require 'httparty'

class Property < ApplicationRecord
  belongs_to :user

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