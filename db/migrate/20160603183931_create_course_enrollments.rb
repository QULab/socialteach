class CreateCourseEnrollments < ActiveRecord::Migration
  def change
    create_table :course_enrollments do |t|
      t.boolean :active
      t.boolean :completed
      t.boolean :is_visible
      t.boolean :is_visible_friends
      t.references :user, index: true
      t.references :course, index: true

      t.timestamps null: false
    end
    add_foreign_key :course_enrollments, :users
    add_foreign_key :course_enrollments, :courses
  end
end
