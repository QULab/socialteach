class AddCourseToChapter < ActiveRecord::Migration
  def change
    add_foreign_key :chapters, :courses
  end
end
