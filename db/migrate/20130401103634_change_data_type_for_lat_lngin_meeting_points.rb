class ChangeDataTypeForLatLnginMeetingPoints < ActiveRecord::Migration
  def up
    change_table :meeting_points do |t|
          t.change :lat, :decimal, {:precision=>10, :scale=>6}
          t.change :lng, :decimal, {:precision=>10, :scale=>6}
        end
  end

  def down
    change_table :widgets do |t|
          t.change :lat, :string
          t.change :lng, :string
        end
  end
end
