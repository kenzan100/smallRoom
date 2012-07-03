class AddDoneCountAndCongrattedCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :progres_count, :integer, default: 0
    add_column :users, :congratted_count, :integer, default: 0
  end
end
