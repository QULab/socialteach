class AddCourseToCourseBadge < ActiveRecord::Migration
  def change
    add_reference :course_badges, :course, index: true
    add_foreign_key :course_badges, :courses
  end
end
