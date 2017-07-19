class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :import]

  def index
    @events = Event.all
  end

  def show
    @attendees = @event.attendees.limit(10)
    @attendee_count = @event.attendees.size
    @progress_message = $redis.hget "Event:#{@event.id}:import_attendee:progress", "msg"
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to new_event_attendee_import_path(@event), notice: 'Event was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
    end
  end
  
  def import_attendees
    Attendee.import(@event, params[:file])
    redirect_to event_path(@event)
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :description, :banner, :webview_link)
    end
end
