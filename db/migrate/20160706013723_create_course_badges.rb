class CreateCourseBadges < ActiveRecord::Migration
  def change
    create_table :course_badges do |t|
      t.string :badge
      t.string :description

      t.timestamps null: false
    end
  end
end
