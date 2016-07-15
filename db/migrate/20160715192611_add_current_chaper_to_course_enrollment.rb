class AddCurrentChaperToCourseEnrollment < ActiveRecord::Migration
  def change
    add_column :course_enrollments, :current_chapter, :integer
  end
end
