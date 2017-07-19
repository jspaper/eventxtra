class AttendeeImportsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @attendee_import = AttendeeImport.new({:event_id => params[:event_id]})
  end
  
  def create
    @event = Event.find(params[:event_id])
    if params[:attendee_import].nil?
      redirect_to new_event_attendee_import_path(@event), :notice => "Please select csv file."
    else
      @event.import_attendees(params[:attendee_import][:file])
      redirect_to event_path(@event)
    end
  end

end
