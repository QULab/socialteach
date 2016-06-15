class AddLevelToCourseEnrollments < ActiveRecord::Migration
  def change
    add_reference :course_enrollments, :level, index: true
    add_foreign_key :course_enrollments, :levels
  end
end
