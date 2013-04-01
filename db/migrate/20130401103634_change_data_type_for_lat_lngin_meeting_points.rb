class ChangeDataTypeForLatLnginMeetingPoints < ActiveRecord::Migration
  def up
    remove_column :meeting_points, :lat
    remove_column :meeting_points, :lng

    add_column :meeting_points, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :meeting_points, :lng, :decimal, {:precision=>10, :scale=>6}

  end

  def down
    change_table :widgets do |t|
          t.change :lat, :string
          t.change :lng, :string
        end
  end
end
