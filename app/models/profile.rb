class Profile < ActiveRecord::Base
  #attr_accessible  :id, :meeting_points_attributes, :max_avg, :created_at, :description, :distance, :min_avg, :updated_at, :user_id, :firstname, :lastname, :city, :lat, :lng , :start_time, :end_time
  belongs_to :user
  has_many :meeting_points
  accepts_nested_attributes_for :meeting_points


end
