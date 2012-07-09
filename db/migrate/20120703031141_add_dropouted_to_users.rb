class AddDropoutedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dropouted, :boolean, default: false
  end
end
