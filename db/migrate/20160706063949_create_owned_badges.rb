class CreateOwnedBadges < ActiveRecord::Migration
  def change
    create_table :owned_badges do |t|
      t.belongs_to :course_badge, index: true
      t.belongs_to :course_enrollment, index: true

      t.timestamps null: false
    end
    add_foreign_key :owned_badges, :course_badges
    add_foreign_key :owned_badges, :course_enrollments
  end
end
