class AttendeeImport
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  
  attr_accessor :file, :event_id
  
  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end
  
  def persisted?
    false
  end
  
  def save
    if imported_attendees.map(&:valid?).all?
      imported_attendees.each(&:save!)
      true
    else
      imported_attendees.each_with_index do |attendee, index|
        attendee.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end
  
  def imported_attendees
    @imported_attendees ||= load_imported_attendees
  end

  def load_imported_attendees
    attendees = []
    CSV.foreach(file.path, headers: true) do |row|
      attendee = Attendee.new
      attendee.attributes = row.to_hash.slice("name", "title", "description")
      attendee.event_id = event_id
      attendees << attendee
    end
    attendees
  end
  
end