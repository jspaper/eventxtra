# == Schema Information
#
# Table name: attendees
#
#  id                  :integer          not null, primary key
#  name                :string           not null
#  title               :string
#  description         :string
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  event_id            :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Attendee < ApplicationRecord
  has_attached_file :avatar, :styles => {medium: "500x500>", thumb: "100x100>", square: "100x100#"}, :default_style => :square
  
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def to_s
    name
  end
  
end
