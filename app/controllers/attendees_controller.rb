class AttendeesController < ApplicationController
  before_action :set_attendee, only: [:destroy]
  
  def index
    @event = Event.find(params[:event_id])
    @attendees = @event.attendees
  end
  
  def destroy
    @attendee.destroy
    respond_to do |format|
      format.html { redirect_to event_attendees_url(@event), notice: 'Attendee was successfully destroyed.' }
    end
  end
  
  private
    def set_attendee
      @event = Event.find(params[:event_id])
      @attendee = Attendee.find(params[:id])
    end

end