class SessionsController < ApplicationController
  def new
  end
  
  def create
    reset_session
    #raise request.env["omniauth.auth"].to_yaml
    user = User.from_omniauth(request.env["omniauth.auth"], {my_custom:params[:my_custom], room_id:params[:room_id]})
    session[:user_id] = user.id
    
    redirect_to user_path(current_user), notice: "signed in!"
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "signed out"
  end
  
  def failure
    redirect_to root_url, alert: "auth failed, pls try again, sorry."
  end

end
