class ListingsController < ApplicationController

  def new
    @listing = Listing.new
  end

  def create

  end

  private

  def listing_params
    params.require(:listing).permit(:type, :name, :website, :location)
  end

end