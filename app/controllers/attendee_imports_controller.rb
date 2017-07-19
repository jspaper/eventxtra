class AttendeeImportsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @attendee_import = AttendeeImport.new({:event_id => params[:event_id]})
  end
  
  def create
    @event = Event.find(params[:event_id])
    @event.import_attendees(params[:attendee_import][:file])
    redirect_to events_path, notice: "Importing attendees..."
  end

end
