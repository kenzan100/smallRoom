class AddTacobeyaToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :tacobeya, :boolean, default: false
  end
end
