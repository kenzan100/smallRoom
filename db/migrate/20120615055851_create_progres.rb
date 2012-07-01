class CreateProgres < ActiveRecord::Migration
  def change
    create_table :progres do |t|
      t.boolean :success
      t.integer :hack_tag_id
      t.integer :user_id
      t.datetime :done_at

      t.timestamps
    end
  end
end
