class CreateCustoms < ActiveRecord::Migration
  def change
    create_table :customs do |t|
      t.integer :user_id
      t.integer :hack_tag_id

      t.timestamps
    end
  end
end
