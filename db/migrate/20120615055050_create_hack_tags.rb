class CreateHackTags < ActiveRecord::Migration
  def change
    create_table :hack_tags do |t|
      t.string :name
      t.string :image_url

      t.timestamps
    end
  end
end
