class PasswordResetsController < ApplicationController
  # GET /reset_password
  def new
    @password_reset_form = PasswordResetForm.new
  end

  # POST /reset_password
  def create
    @password_reset_form = PasswordResetForm.new
    if @password_reset_form.submit(password_params)
      session[:user_id] = @password_reset_form.user.id
      redirect_to :bikes_path, notice: "Your password has been reset."
    else
      render :new
    end
  end

  def password_params
    params.require(:password_reset)
    params[:password_reset].permit(:email, :password, :password_confirmation)
  end
end

