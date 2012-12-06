class MeetingPoint < ActiveRecord::Base
  attr_accessible :id, :lat, :long, :description#, :meeting_points_attributes
  #has_one :profile
  belongs_to :profile
  #accepts_nested_attributes_for :profile
  scope :without_own_profile, lambda {   |profile_id|
    joins(:profile).
    where('user_id != ?', profile_id)
  }
end
