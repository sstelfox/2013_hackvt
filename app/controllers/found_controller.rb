class FoundController < ApplicationController
  def new
    @title = "Submit a Bike You Found"
    @found_form = FoundForm.new
  end

  def create
    @found_form = FoundForm.new

    if @found_form.submit(found_params)
      redirect_to root_path, notice: "Thank you for submitting the information about the bike"
    else
      render :new
    end
  end

  def found_params
    params.require(:found)
    params[:found].permit(:serial, :frame_make, :frame_model, :phone, :email, :description)
  end
end
