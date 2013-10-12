class PagesController < ApplicationController
  def landing
    @incidents = Incident.geocoded.select(:latitude, :longitude).limit(100)
  end

  def faq
    @title = "Frequently Asked Questions"
  end
end
