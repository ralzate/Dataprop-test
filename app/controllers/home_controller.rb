class HomeController < ApplicationController
  def index
    @properties = Property.all

    @property_types = {
      'Arriendo' => 'rent',
      'Venta' => 'sale'
    }

    if params[:query].present?
      @properties = @properties.where("address ILIKE ? OR description ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    if params[:property_type].present?
      @properties = @properties.where(property_type: params[:property_type])
    end

    if params[:min_price].present? && params[:max_price].present?
      @properties = @properties.where(price: params[:min_price]..params[:max_price])
    end

    if params[:bedrooms].present?
      @properties = @properties.where(bedrooms: params[:bedrooms])
    end

    if params[:bathrooms].present?
      @properties = @properties.where(bathrooms: params[:bathrooms])
    end
  end
end