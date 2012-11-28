class Message < ActiveRecord::Base
  attr_accessible :message, :parent_id, :user_id
end
