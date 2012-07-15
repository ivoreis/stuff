class EventsController < ApplicationController
  respond_to :html, :json, :xml

  def list
    @events = Event.by_owner(current_person)
    @events = @events.after(params['start']) if (params['start'])
    @events = @events.before(params['end']) if (params['end'])
    respond_with(@events)
  end

  def create
    @event = Event.new params[:event]
    @event.owner = current_person
    @event.creator = current_person
    @event.save!
    respond_with(@event, location: calendar_url)
  end

  def update
    @event = Event.find(params[:id])
    @event.title      = params[:event][:title]
    @event.details    = params[:event][:details]
    @event.starts_at  = params[:event][:starts_at]
    @event.ends_at    = params[:event][:ends_at]
    @event.all_day    = params[:event][:all_day]
    @event.save!
    respond_with(@event, location: calendar_url)
  end

end