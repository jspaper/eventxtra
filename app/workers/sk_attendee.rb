class SkAttendee < SkQueue
  sidekiq_options :logger_path => "#{Rails.root}/log/attendee.log"
  
  def import(file_path, event_id)
    CSV.foreach(file_path, headers: true) do |row|
      attendee = Attendee.new
      attendee.attributes = row.to_hash.slice("name", "title", "description")
      attendee.event_id = event_id
      attendee.save!
      logger.debug "Created attendee(#{attendee}) of event(#{event_id})."
    end
  end
  
end