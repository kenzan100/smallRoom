class AddCommentToProgres < ActiveRecord::Migration
  def change
    add_column :progres, :comment, :string
  end
end
