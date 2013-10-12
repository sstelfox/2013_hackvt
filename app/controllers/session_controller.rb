class SessionController < ApplicationController
  # GET /login
  def new
    redirect_to :root_path if current_user
    @login_form = LoginForm.new
  end

  # POST /login
  def create
    @login_form = LoginForm.new

    if @login_form.submit(login_params)
      session[:user_id] = @login_form.user.id
      redirect_to root_path, notice: "You've been successfully logged in."
    else
      render "new"
    end
  end

  # DELETE & GET /logout
  def destroy
    if current_user
      session[:user_id] = nil
      redirect_to root_path, notice: "You've been successfully logged out."
    else
      redirect_to root_path, notice: "You need to be logged in before you can logout"
    end
  end

  def login_params
    params.require(:login)
    params[:login].permit(:email, :password)
  end
end
