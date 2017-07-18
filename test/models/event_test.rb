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

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
