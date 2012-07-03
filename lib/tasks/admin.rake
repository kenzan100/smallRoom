namespace :admin do
  task :check_dropouts_and_remove_friendships => :environment do
    User.find_each do |user|
      if user.progres.order('done_at').last < (Time.now.beginning_of_day - 3.days)
        user.friendships.destroy.delete_all
        user.inverse_friendships.delete_all
      end
    end
  end
  
  task :calculate_progres_count => :environment do
    User.find_each do |user|
      User.update_counters user.id, progres_count: user.progres.length
    end
  end
end