class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show

  end

  def difference
    location = Location.all
    hash = { }

    for i in (0..location.length-1)
      for j in ((i+1)..(location.length-1))
         puts "Distance between" +" " +location[i][:address] + "and" +" " +location[j][:address] + "is"
         value = Geocoder::Calculations.distance_between([location[i][:latitude],location[i][:longitude]] , [location[j][:latitude] , location[j][:longitude]]).round(2)
         puts value 
         key = location[i][:address]+" "+"and"+" "+location[j][:address]
         hash[key] = value
      end
    end
    
     @least = [hash.min_by{|k, v| v}].to_h

     @distance = @least.values[0]

     @city = @least.keys[0]
    
    render 'difference'
  end 

  def calucate_difference
    @location = Location.all
    puts params[:city]
    city1 = @location.find_by(address: params[:city1])
    lat1 = city1[:latitude]
    long1 = city1[:longitude]

    city2 = @location.find_by(address: params[:city2])
    lat2= city2[:latitude]
    long2 = city2[:longitude]

    @distance = Geocoder::Calculations.distance_between([lat1,long1] , [lat2,long2])

    render 'difference'
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:address, :latitude, :longitude)
    end
end
