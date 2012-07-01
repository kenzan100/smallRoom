class AddLastTimeCongrattedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_time_congratted_at, :datetime
  end
end
