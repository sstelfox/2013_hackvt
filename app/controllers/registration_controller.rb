
class RegistrationController < ApplicationController
  # GET /register
  def new
    @registration_form = RegistrationForm.new
  end

  # POST /registep
  def create
    @registration_form = RegistrationForm.new
    if @registration_form.submit(params[:user])
      session[:user_id] = @registration_form.user.id
      redirect_to @registration_form.user, notice: "Thank you for registering!"
    else
      render "new"
    end
  end
end
