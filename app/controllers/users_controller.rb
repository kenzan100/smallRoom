class UsersController < ApplicationController
  def ask
    @user = User.find(params[:id])
  end
  
  def show
    if current_user.id == params[:id].to_i
      @user          = User.find(params[:id])
      @friends       = @user.same_room_with
      @hack_tags     = @user.hack_tags
      
      @progre        = Progre.new
      @incomplete_hack_tags = @hack_tags - @hack_tags.joins(:progres).where('progres.user_id = ? AND progres.done_at > ?', @user.id, Time.now.beginning_of_day).all
      @todays_your_last_progre = @user.progres.where('progres.done_at > ?', Time.now.beginning_of_day).last
      
      @progres_records = @user.progres
      @progres_records = @progres_records + @friends.map{|u|u.progres}.flatten! if @friends.present?
      @progres_records = @progres_records.sort_by{|p| p.done_at}.reverse
    else
      redirect_to root_url, alert: "that's not your page"
    end
  end
  
  def index
    if current_user
      redirect_to user_path(current_user), notice: alert
    else
      @users_for_you = (User.order('friendships_count') - User.joins(:friendships, :inverse_friendships)).last
      @user          = User.new
    end
  end
  
  def create
    redirect_to new_identity_path(my_custom:params[:my_custom], nick_name:params[:nick_name], first_friend_id:params[:first_friend_id])
  end

end
