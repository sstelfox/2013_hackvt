
class IncidentsController < ApplicationController
  # GET /bikes/1/report_stolen
  # GET /report_stolen
  def new
    bike = !!bike_id ? Bike.where(user: current_user).find(bike_id) : nil
    @incident_form = IncidentForm.new(bike, current_user)
  end

  # POST /bikes/1/report_stolen
  # POST /report_stolen
  def create
    bike = !!bike_id ? Bike.where(user: current_user).find(bike_id) : nil
    @incident_form = IncidentForm.new(bike, current_user)

    if @incident_form.submit(incident_params)
      session[:user_id] = @incident_form.user.id unless current_user
      redirect_to bikes_path, notice: "You incident has been reported"
    else
      @last_seen = params[:incident][:last_seen]
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
      :officer_name, :station, :first_name, :last_name, :email, :password,
      :password_confirmation)
  end
end
