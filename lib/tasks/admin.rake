namespace :admin do
  task :check_dropouts => :environment do
    User.find_each do |user|
      if user.progres.order('done_at').last < (Time.now.beginning_of_day - 3.days)
        user.friendships.destroy.delete_all
        user.inverse_friendships.delete_all
      end
    end
  end
end