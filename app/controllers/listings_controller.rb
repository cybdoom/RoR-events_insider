class ListingsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def new
    @listing = Listing.new(type: :event)
  end

  def create
    listing = Listing.new(listing_params)

    if listing.valid?
      redirect_to listing.path_for_redirect
    else
      render 'new'
    end
  end



  private

  def listing_params
    params.require(:listing).permit(:type, :name, :website, :location)
  end

end
