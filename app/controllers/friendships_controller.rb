class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      redirect_to current_user, notice: "friendship created"
    else
      redirect_to current_user, notice: "failed, sorry."
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    redirect_to current_user, notice: "removed friendship"
  end

end
