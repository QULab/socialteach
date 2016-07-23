class AddCourseAndActivityToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :course, index: true
    add_foreign_key :comments, :courses
    add_reference :comments, :activity, index: true
    add_foreign_key :comments, :activities
  end
end
