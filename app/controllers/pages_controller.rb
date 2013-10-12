class PagesController < ApplicationController
  def landing
  end

  def faq
    @title = "Frequently Asked Questions"
  end
end
