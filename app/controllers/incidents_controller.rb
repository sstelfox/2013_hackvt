
class IncidentsController < ApplicationController
  before_action :authenticate_user

  # GET /bikes/1/report_stolen
  # GET /report_stolen
  def new
    bike = !!bike_id ? Bike.find(bike_id) : nil
    @incident_form = IncidentForm.new(bike)
  end

  # POST /bikes/1/report_stolen
  # POST /report_stolen
  def create
    bike = !!bike_id ? Bike.find(bike_id) : nil
    @incident_form = IncidentForm.new(bike)

    if @incident_params.submit(incident_params)
      redirect_to bikes_path, notice: "You incident has been reported"
    else
      render "new"
    end
  end

  def bike_id
    params.permit(:id)[:id]
  end

  def incident_params
    params.require(:incident)
    params[:incident].permit(:serial, :frame_make, :frame_model, :color,
      :description, :last_seen, :last_location, :police_incident_number,
      :officer_name, :station)
  end
end
