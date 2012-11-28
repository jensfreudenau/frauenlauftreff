class AddDescriptionToMeetingPoint < ActiveRecord::Migration
  def change
    add_column :meeting_points, :description, :string
  end
end
