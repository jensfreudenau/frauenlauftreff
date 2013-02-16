class Profile < ActiveRecord::Base
  attr_accessible :max_avg, :created_at, :description, :distance, :min_avg, :updated_at, :user_id, :firstname, :lastname, :city, :lat, :lng
  has_one :user
  has_many :meeting_points
  accepts_nested_attributes_for :meeting_points
  attr_accessible :id, :meeting_points_attributes, :profile_id , :lat, :long, :user_attributes

end
