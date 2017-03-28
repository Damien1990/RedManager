class ManagersController < ApplicationController
  def new
    @manager = Manager.new
    @countries = Country.all
  end
end