class LocationsController < ApplicationController
  before_filter :authenticate_user!, only: [:search]

  def search
    location = SearchForm::Location.new(location: params[:location])

    locations = location.search(current_user)
  end



  private

  def location_params
    params.fetch(:search_form_location, {}).permit(:location)
  end

end