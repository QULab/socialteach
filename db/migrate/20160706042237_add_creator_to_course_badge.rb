class AddCreatorToCourseBadge < ActiveRecord::Migration
  def change
    add_reference :course_badges, :user, index: true
    add_foreign_key :course_badges, :users
  end
end
