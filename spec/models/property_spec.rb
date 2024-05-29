require 'rails_helper'

RSpec.describe Property, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:property_type) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:district) }
    it { should have_many_attached(:photos) }
  end

  describe '#converted_price' do
    before do
        response_double = double(success?: true, parsed_response: { 'dolar' => { 'valor' => 800 } })

        allow(HTTParty)
            .to receive(:get)
            .and_return(response_double)
    end

    context 'when currency is USD' do
        let(:property) { create(:property, currency: 'USD', price: 100) }

        it 'converts price to CLP' do
            expect(property.converted_price).to eq({ amount: 80_000, currency: 'CLP' })
        end
    end

    context 'when currency is CLP' do
        let(:property) { create(:property, currency: 'CLP', price: 100) }

        it 'converts price to USD' do
            expect(property.converted_price).to eq({ amount: 0.13, currency: 'USD' })
        end
    end
  end
end