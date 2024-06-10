class EventsController < ApplicationController
    def show
      @event = Event.friendly.find(params[:id])

      # Convert to desired timezone, e.g., Eastern Daylight Time (EDT)
      event_timestamp_in_edt = @event.start_time.in_time_zone('Eastern Time (US & Canada)')

      # Format the timestamp
      @formatted_timestamp = event_timestamp_in_edt.strftime("%A, %B #{event_timestamp_in_edt.day.ordinalize} @ %l:%M %p %Z")
    end

    def index
      @events = Event.all.order(start_time: :asc)
    end
  end
  