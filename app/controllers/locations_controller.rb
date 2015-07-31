class LocationsController < ApplicationController
  before_filter :authenticate_user!, only: [:search]

  respond_to :html, :js

  def search
    location = SearchForm::Location.new(address: params[:address])

    locations = location.search(current_user)

    render json: locations
  end


end
