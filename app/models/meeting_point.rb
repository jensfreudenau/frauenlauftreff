class MeetingPoint < ActiveRecord::Base
  attr_accessible :id, :lat, :lng, :description#, :meeting_points_attributes
  #has_one :profile
  belongs_to :profile
  #accepts_nested_attributes_for :profile
  scope :without_own_profile, lambda {   |profile_id|
    joins(:profile).
    where('user_id != ?', profile_id)
  }

  scope :map_points_wo_own_profile, lambda { |args|
    joins("LEFT JOIN profiles ON meeting_points.profile_id = profiles.id")
    .where('profiles.user_id != ?', args[:user_id].to_i)
    .where('meeting_points.lat > ?', args[:latmin].to_f)
    .where('meeting_points.lng > ?', args[:lngmin].to_f)
    .where('meeting_points.lat < ?', args[:latmax].to_f)
    .where('meeting_points.lng < ?', args[:lngmax].to_f)
    .all
  }
end
