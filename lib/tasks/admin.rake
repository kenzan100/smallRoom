namespace :admin do
  task :check_dropouts_and_remove_friendships => :environment do
    User.find_each do |user|
      if user.progres.order('done_at').last < (Time.now.beginning_of_day - 3.days)
        #user.friendships.destroy.delete_all
        #user.inverse_friendships.delete_all
        user.room_id   = Room.find_by_tacobeya(true).id
        user.dropouted = true
        user.save!
      end
    end
  end
  
  task :connect_remaining_rooms => :environment do
    Room.where('tacobeya = false').find_each do |room|
      how_many_in_it = room.users.count
      if how_many_in_it == 2
        room_alone = Room.where('tacobeya = false').find_by_users_count(1)
        room.merge(room_alone) if room_alone.present?
      elsif how_many_in_it == 1
        room_child = Room.where('tacobeya = false').find_by_users_count(2)
        room.merge(room_child) if room_child.present?
      end
    end
  end
  
  task :calculate_progres_count => :environment do
    User.find_each do |user|
      User.update_counters user.id, progres_count: user.progres.length
    end
  end
end