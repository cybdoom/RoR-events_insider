class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search]

  def new
    @event = Event.new(event_params)
    @event.build_venue
  end

  def create
    @event = Event.new(event_params)
  end

  def search
    redirect_to root_path, flash: { warning: I18n.t('flash.warnings.we_moved') }
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

  def search_params
    result = params.permit(:year, :date, :old_title)
    result[:date] = DateTime.parse(
      (result[:date].split('-').reverse << result[:year]).join('-')
    )
    result.tap {|result| result.delete :year }
  end

end
