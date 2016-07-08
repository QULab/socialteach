class AddDifficultyToCourseEnrollment < ActiveRecord::Migration
  def change
    add_column :course_enrollments, :difficulty, :integer, :default => 3
  end
end
