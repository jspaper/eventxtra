class SkAttendee < SkQueue
  sidekiq_options :logger_path => "#{Rails.root}/log/attendee.log"
  
  def import(file_path, event_id, count)
    index = 0
    event = Event.find(event_id)
    CSV.foreach(file_path, headers: true) do |row|
      sleep 3
      index = index + 1
      attendee = Attendee.new
      attendee.attributes = row.to_hash.slice("name", "title", "description")
      attendee.event_id = event_id
      attendee.save!
      
      logger.info "Importing attendees (#{index}/#{count}) of event(#{event_id})"
      $redis.hset event.import_key, "msg", "Importing attendees(#{index}/#{count})."
    end
    
    # Delete redis data on finish importing
    $redis.del event.import_key
  end
  
end