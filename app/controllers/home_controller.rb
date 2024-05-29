class HomeController < ApplicationController
  def index
    @properties = Property.all

    @property_types = {
      'Arriendo' => 'rent',
      'Venta' => 'sale'
    }

    @properties = @properties.filter_by_query(params[:query]) if params[:query].present?
    @properties = @properties.filter_by_property_type(params[:property_type]) if params[:property_type].present?
    @properties = @properties.filter_by_price(params[:min_price], params[:max_price]) if params[:min_price].present? && params[:max_price].present?
    @properties = @properties.filter_by_bedrooms(params[:bedrooms]) if params[:bedrooms].present?
    @properties = @properties.filter_by_bathrooms(params[:bathrooms]) if params[:bathrooms].present?

    @properties = @properties.page(params[:page]).per(10)
  end
end