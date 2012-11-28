class CreateMeetingPoints < ActiveRecord::Migration
  def change
    create_table :meeting_points do |t|
      t.string :lat
      t.string :long
      t.integer :profile_id

      t.timestamps
    end
  end
end
