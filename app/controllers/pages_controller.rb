class PagesController < ApplicationController
  before_action :authenticate_user!, only: :home

  def landing
  end

  def home
    @title = "Dashboard"
  end

end
