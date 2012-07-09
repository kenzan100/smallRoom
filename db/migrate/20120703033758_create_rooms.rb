class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :users_count, default: 0

      t.timestamps
    end
    Room.reset_column_information
  end
end
