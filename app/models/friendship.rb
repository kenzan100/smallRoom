class Friendship < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :friend, class_name: "User"
end
