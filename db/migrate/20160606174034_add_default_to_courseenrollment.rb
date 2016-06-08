class AddDefaultToCourseenrollment < ActiveRecord::Migration
  def change
      change_column_default :course_enrollments, :completed, false
      change_column_default :course_enrollments, :active, true
  end
end
