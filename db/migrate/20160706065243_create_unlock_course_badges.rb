class CreateUnlockCourseBadges < ActiveRecord::Migration
  def change
    create_table :unlock_course_badges do |t|
      t.belongs_to :course_badge, index: true
      t.belongs_to :activity, index: true

      t.timestamps null: false
    end
    add_foreign_key :unlock_course_badges, :course_badges
    add_foreign_key :unlock_course_badges, :activities
  end
end
