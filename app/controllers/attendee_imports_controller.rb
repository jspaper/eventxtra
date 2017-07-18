class AttendeeImportsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @attendee_import = AttendeeImport.new({:event_id => params[:event_id]})
  end
  
  def create
    @attendee_import = AttendeeImport.new(params[:attendee_import])
    if @attendee_import.save
      redirect_to events_path, notice: "Imported attendees successfully."
    else
      render :new
    end
  end

end
