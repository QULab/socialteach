class CreateActivityStatuses < ActiveRecord::Migration
  def change
    create_table :activity_statuses do |t|
      t.boolean :is_completed
      t.integer :Status
      t.references :Activity
      t.references :Course_enrollment

      t.timestamps null: false
    end
    add_foreign_key :activity_statuses, :Activity
    add_foreign_key :activity_statuses, :Course_enrollment
  end
end
