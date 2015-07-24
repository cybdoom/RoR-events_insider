class EventsController < ApplicationController

  def new
  end

  def create
  end



  private

  def event_params
    params.require(:event).permit(:id)
  end

end