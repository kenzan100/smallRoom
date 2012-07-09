class UsersController < ApplicationController
  def ask
    @user = User.find(params[:id])
  end
  
  def show
    if current_user && current_user.id == params[:id].to_i
      @user          = User.find(params[:id])
      @roommates     = @user.room.users
      @hack_tags     = @user.hack_tags
      
      @progre        = Progre.new
      @incomplete_hack_tags = @hack_tags - @hack_tags.joins(:progres).where('progres.user_id = ? AND progres.done_at > ?', @user.id, Time.now.beginning_of_day).all
      @todays_your_last_progre = @user.progres.where('progres.done_at > ?', Time.now.beginning_of_day).last
      
      @progres_records = @roommates.map{|u|u.progres}.flatten! if @roommates.present?
      @progres_records = @progres_records.sort_by{|p| p.done_at}.reverse
    else
      redirect_to root_url, alert: "you haven't logged in, or that's not your page"
    end
  end
  
  def index
    if current_user
      redirect_to user_path(current_user), notice: alert
    else
      @available_room = Room.where('users_count < 3 AND tacobeya = false').order('users_count').last || Room.create!
      #@users_for_you = (User.order('friendships_count') - User.joins(:friendships, :inverse_friendships)).last
      @user          = User.new
    end
  end
  
  def create
    redirect_to new_identity_path(my_custom:params[:my_custom], nick_name:params[:nick_name], room_id:params[:room_id])
  end

end
