class RenameLongToLng < ActiveRecord::Migration
  def up
    rename_column :meeting_points, :long, :lng
  end

  def down
    rename_column :meeting_points, :lng, :long
  end
end
