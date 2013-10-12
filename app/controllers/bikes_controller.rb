class BikesController < ApplicationController

  def index
    @bikes = current_user.bikes
  end

  def new
    @bike = Bike.new
  end

  def create
    @bike = Bike.new(params[:bike])
    @bike.user = current_user
    if @bike.save
      redirect_to bikes_path
    else
      render :new
    end
  end

  def show
    @bike = Bike.find(params[:id])
    #TODO is this __my__ bike?
  end

  def edit
    @bike = Bike.find(params[:id])
  end

  def update
    @bike = Bike.find(params[:id])
    @bike.update_attributes(params[:bike])
    if @bike.save
      redirect_to bikes_path
    else
      render :new
    end
  end

  def destroy
    @bike = Bike.find(params[:id])
    @bike.delete
  end

end
