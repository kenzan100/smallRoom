class AddFriendshipsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :friendships_count, :integer, default: 0
    User.reset_column_information
  end
end
