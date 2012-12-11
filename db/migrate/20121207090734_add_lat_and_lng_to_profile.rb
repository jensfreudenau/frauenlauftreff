class AddLatAndLngToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :lat, :string
    add_column :profiles, :lng, :string
  end
end
