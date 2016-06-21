class AddCreatorIdToCourses < ActiveRecord::Migration
  def change
      add_column :courses, :creator_id, :integer
      change_column :courses, :creator_id, :integer, null: false
  end
end
