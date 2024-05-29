class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_districts, only: [:new, :edit, :create, :update]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @properties = Property.all
  end

  def show
  end

  def new
    @property = Property.new
  end

  def edit
  end

  def create
    @property = current_user.properties.build(property_params)

    respond_to do |format|
      if @property.save
        format.html { redirect_to property_url(@property), notice: "Property was successfully created." }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to property_url(@property), notice: "Property was successfully updated." }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @property.destroy

    respond_to do |format|
      format.html { redirect_to properties_url, notice: "Property was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def set_districts
    @districts = District.all
  end

  def property_params
    params.require(:property).permit(:property_type, :price, :currency, :district_id, :address, :area, :bedrooms, :bathrooms, :latitude, :longitude, :description, photos: [])
  end

  def authorize_user!
    unless current_user == @property.user
      redirect_to @property, alert: "You are not authorized to perform this action."
    end
  end
end
