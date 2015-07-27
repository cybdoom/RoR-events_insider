class EventsController < ApplicationController

  def new
    @event = Event.new(event_params)
    @event.build_venue
  end

  def create
    @event = Event.new(event_params)
  end



  private

  def event_params
    params.require(:event)
          .permit(:id,
                  :name,
                  :description,
                  :recurring,
                  :starts_at,
                  :ends_at,
                  :price,
                  :estimated_attendance,
                  venue_attributes: [:location_id])
  end

end