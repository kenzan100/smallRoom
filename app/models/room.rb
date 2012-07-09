class Room < ActiveRecord::Base
  has_many :users
  validate :room_capacity
  
  def merge(another_room)
    rooms = [self, another_room]
    bigger_room  = rooms.sort_by{|r| r.users_count}.last
    smaller_room = rooms.sort_by{|r| r.users_count}.first
    smaller_room.users.each{|u| u.update_attributes(room_id: bigger_room.id)}
    smaller_room.destroy
    bigger_room
  end
  
  private
  def room_capacity
    return if users.blank? || self.tacobeya == true
    errors.add("Too many ppl in one room") if users.length > 3
  end
  
end
