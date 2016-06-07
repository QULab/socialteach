class CreateActivityStatuses < ActiveRecord::Migration
  def change
    create_table :activity_statuses do |t|
      t.boolean :is_completed
      t.integer :Status
      t.reference :Activity
      t.reference :Course_enrollment

      t.timestamps null: false
    end
  end
end
