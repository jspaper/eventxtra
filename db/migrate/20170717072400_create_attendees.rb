class CreateAttendees < ActiveRecord::Migration[5.1]
  def change
    create_table :attendees do |t|
      t.string :name, :null => false
      t.string :title
      t.string :description
      t.attachment :avatar
      t.references :event
      t.timestamps
    end
  end
end
