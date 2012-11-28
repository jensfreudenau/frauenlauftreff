class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :max_avg
      t.string :min_avg
      t.string :distance
      t.string :description
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :user_id

      t.timestamps
    end
  end
end
