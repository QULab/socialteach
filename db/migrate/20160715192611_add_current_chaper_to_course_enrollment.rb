class AddCurrentChaperToCourseEnrollment < ActiveRecord::Migration
  def change
    add_column :course_enrollments, :current_chapter_id, :integer
  end
end
