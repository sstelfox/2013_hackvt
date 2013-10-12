require 'craigslist'

class BikesController < ApplicationController
  before_action :authenticate_user, except: [:search, :perform_search]

  def index
    @title = "My Bikes"
    @bikes = current_user.bikes
  end

  def new
    @title = "Register a Bike"
    @bike = Bike.new
  end

  def create
    @bike = Bike.new( bike_params )
    @bike.status = "normal"

    @bike.user = current_user
    if @bike.save
      redirect_to bikes_path
    else
      render :new
    end
  end

  def edit
    @bike = current_user.bikes.find(params[:id])
    @title = "Update bike: #{@bike.frame_make} #{@bike.frame_model}"
  end

  def update
    @bike = current_user.bikes.find(params[:id])
    @bike.update_attributes(bike_params)
    if @bike.save
      redirect_to bikes_path
    else
      render :new
    end
  end

  def destroy
    @bike = current_user.bikes.find(params[:id])
    @bike.delete
    redirect_to bikes_path
  end

  def craigslist
    @bike = current_user.bikes.find(params[:id])
    @results = Craigslist.burlington.bikes.query(@bike.frame_make).fetch
  end

  def report_returned
    @bike = Bike.find(params[:id])
    @bike.status = "normal"
    @bike.save
    redirect_to bikes_path, notice: "Glad you found your bike!"
  end

  def destroy
    @bike = Bike.find(params[:id])
    @bike.delete
    redirect_to bikes_path
  end

  def qr
    @bike = current_user.bikes.find(params[:id])
    render :qr
  end

  private

  def bike_params
    params.require(:bike)
    params[:bike].permit(:serial, :frame_make, :frame_model, :color, :description)
  end
end
