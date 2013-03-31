class AddStartTimeEndTimeToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :start_time, :Time
    add_column :profiles, :end_time, :time
  end
end
