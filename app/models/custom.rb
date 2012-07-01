class Custom < ActiveRecord::Base
  belongs_to :user
  belongs_to :hack_tag
end
