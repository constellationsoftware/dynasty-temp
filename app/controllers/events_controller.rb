class EventsController < ApplicationController
  def index
    @events = Event.winners
  end
end
