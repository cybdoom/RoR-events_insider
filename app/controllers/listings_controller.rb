class ListingsController < ApplicationController

  def new
    @listing = Listing.new(type: :event)
  end

  def create
    listing = Listing.new(listing_params)

    respond_with listing do |format|
      format.html do
        if listing.valid?
          redirect_to listing.path_for_redirect
        else
          render 'new'
        end
      end
    end
  end



  private

  def listing_params
    params.require(:listing).permit(:type, :name, :website, :location)
  end

end