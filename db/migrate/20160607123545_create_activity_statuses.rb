class CreateActivityStatuses < ActiveRecord::Migration
  def change
    create_table :activity_statuses do |t|
      t.boolean :is_completed
      t.integer :status
      t.references :activity, index: true
      t.references :course_enrollment, index: true

      t.timestamps null: false
    end
    add_foreign_key :activity_statuses, :activities
    add_foreign_key :activity_statuses, :course_enrollments
  end
end
