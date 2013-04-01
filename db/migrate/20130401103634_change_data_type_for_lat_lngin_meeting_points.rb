class ChangeDataTypeForLatLnginMeetingPoints < ActiveRecord::Migration
  def up
    change_table :meeting_points do |t|
          t.change :lat, :BigDecimal
          t.change :lng, :BigDecimal
        end
  end

  def down
    change_table :widgets do |t|
          t.change :lat, :string
          t.change :lng, :string
        end
  end
end
