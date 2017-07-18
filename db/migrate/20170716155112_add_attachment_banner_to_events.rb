class AddAttachmentBannerToEvents < ActiveRecord::Migration[5.1]
  def self.up
    change_table :events do |t|
      t.attachment :banner
    end
  end

  def self.down
    remove_attachment :events, :banner
  end
end
