class AddChapterToActivities < ActiveRecord::Migration
  def change
    add_reference :activities, :chapter, index: true
    add_foreign_key :activities, :chapters
  end
end
