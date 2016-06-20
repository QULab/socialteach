class AddMeritFieldsToCourseEnrollments < ActiveRecord::Migration
  def change
    add_column :course_enrollments, :sash_id, :integer
    add_column :course_enrollments, :level,   :integer, :default => 0
  end
end
