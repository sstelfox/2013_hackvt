class BikesController < ApplicationController

  def index
    if current_user
      @bikes = current_user.bikes
    else
      # TODO
      @bikes = Bike.all
    end

  end

  def new
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
    @bike = Bike.find(params[:id])
  end

  def update
    @bike = Bike.find(params[:id])
    @bike.update_attributes(bike_params)
    if @bike.save
      redirect_to bikes_path
    else
      render :new
    end
  end

  def destroy
    @bike = Bike.find(params[:id])
    @bike.delete
    redirect_to bikes_path
  end

  def report_stolen
    # TODO
  end

  def search
    # TODO
  end

  def perform_search
    # TODO
  end

  private
  def bike_params
    params.require(:bike)
    params[:bike].permit(:serial, :frame_make, :frame_model, :color, :description)
  end
end
