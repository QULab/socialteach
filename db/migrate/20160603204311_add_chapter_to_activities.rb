class AddChapterToActivities < ActiveRecord::Migration
  def change
    add_foreign_key :activities, :chapters
  end
end
