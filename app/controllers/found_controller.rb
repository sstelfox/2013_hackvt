class FoundController < ApplicationController
  def new
    @title = "Submit a Bike You Found"
    @found_form = FoundForm.new
  end

  def create
    @found_form = FoundForm.new

    if @found_form.submit(found_params)
      redirect_to :root_path, notice: "Thank you for submitting the information about the bike"
    else
      render :new
    end
  end
end
