class SkAttendee < SkQueue
  sidekiq_options :logger_path => "#{Rails.root}/log/attendee.log"
  
  def import(attendee_params, count)
    attendee_params.symbolize_keys!
    
    sleep 3 # Slow I/O simulation
    
    event = Event.find(attendee_params[:event_id])
    event.attendees.create attendee_params
    
    finished_count = $redis.hincrby event.import_key, "finished_count", 1
    $redis.hset event.import_key, "msg", "Importing attendees(#{finished_count}/#{count})."
    logger.info "Importing attendees (#{finished_count}/#{count}) of event(##{event.id})"
    
    # Delete redis data on finish importing
    $redis.del event.import_key if finished_count >= count
  end
  
end