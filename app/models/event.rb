# == Schema Information
#
# Table name: events
#
#  id                  :integer          not null, primary key
#  name                :string
#  description         :string
#  webview_link        :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  banner_file_name    :string
#  banner_content_type :string
#  banner_file_size    :integer
#  banner_updated_at   :datetime
#

class Event < ApplicationRecord
  has_attached_file :banner, :styles => {medium: "500x500>", thumb: "100x100>"},
                             :default_style => :thumb
  
  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\z/

  has_many :attendees, :dependent => :destroy
  
  validates :name, :presence => true, :length => {:minimum => 3, :maxium => 40}
  validates :description, :presence => true, :length => {:minimum => 3, :maxium => 500}
  
  def to_s
    name
  end

  def import_attendees(file)
    count = CSV.read(file.path).size - 1
    logger.debug "Importing #{count} attendee from CSV"
    
    # Set progress in redis
    $redis.hmset import_key, "msg", "Importing #{count} attendee", "count", count, "finished_count", 0

    CSV.foreach(file.path, headers: true) do |row|
      SkAttendee.import(row.to_hash.slice("name", "title", "description").merge({"event_id": id}).symbolize_keys!, count)
    end
  end
  
  def import_key
    "Event:#{id}:import_attendee:progress"
  end
  
end
