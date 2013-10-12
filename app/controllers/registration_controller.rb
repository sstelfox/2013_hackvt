
class RegistrationController < ApplicationController
  # GET /register
  def new
    redirect_to root_path if current_user

    @registration_form = RegistrationForm.new
  end

  # POST /register
  def create
    redirect_to root_path if current_user

    @registration_form = RegistrationForm.new

    if @registration_form.submit(registration_params)
      session[:user_id] = @registration_form.user.id
      redirect_to root_path, notice: "Thank you for registering!"
    else
      render "new"
    end
  end

  def registration_params
    params.require(:registration)
    params[:registration].permit(:email, :password, :password_confirmation)
  end
end
