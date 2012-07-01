class ProgresController < ApplicationController
  def index
  end
  
  def create_all
    
  end
  
  def create
    if params[:hack_tag_ids]
      for hack_tag_id in params[:hack_tag_ids]
        progre = Progre.new(params[:progre])
        progre.hack_tag_id = hack_tag_id
        unless Progre.where('user_id = ? AND done_at > ? AND hack_tag_id = ?', progre.user.id, Time.now.beginning_of_day, progre.hack_tag_id).exists?
          progre.save!
          last_progre = progre
        end
      end
      if last_progre && last_progre.user.same_room_with.present? && (last_progre.user.same_room_with.map{|u| u.progres.done_today.present?}.index(false)) == nil
        users = [last_progre.user, last_progre.user.same_room_with].flatten!
        users.each do |user|
          if user.last_time_congratted_at.blank? || user.last_time_congratted_at < Time.now.beginning_of_day
            UserMailer.send_congrats(user, last_progre.user).deliver
            user.last_time_congratted_at = Time.now
            user.save!
          end
        end
        redirect_to user_path(current_user), notice: "congrats!!!"
      else
        redirect_to user_path(current_user), notice: "nice!"
      end
    else
      redirect_to user_path(current_user), alert: "nothing done.."
    end
  end
  
  def update
    @progre = Progre.find(params[:id])
    if @progre.update_attributes(params[:progre])
      redirect_to @progre.user, notice: "great!"
    else
      redirect_to @progre.user, alert:"sorry, try again."
    end
  end

end
