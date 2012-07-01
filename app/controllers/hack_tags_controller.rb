class HackTagsController < ApplicationController
  def show
    @hack_tag    = HackTag.find(params[:id])
    @progre      = Progre.new
    @your_progre = Progre.find_by_user_id(current_user.id) if current_user
    
    @first_user  = @hack_tag.users.first
    @second_user = @hack_tag.users.offset(1).first
    @third_user  = @hack_tag.users.offset(2).first
  end

end
