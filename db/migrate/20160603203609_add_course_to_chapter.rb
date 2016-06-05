class AddCourseToChapter < ActiveRecord::Migration
  def change
    add_reference :chapters, :course, index: true
    add_foreign_key :chapters, :courses
  end
end
