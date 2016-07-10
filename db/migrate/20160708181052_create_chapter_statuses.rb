class CreateChapterStatuses < ActiveRecord::Migration
  def change
    create_table :chapter_statuses do |t|
      t.boolean :skip, :default => false
      t.references :course_enrollment, index: true
      t.timestamps null: false
      t.float :difficultyFit, :default => 0.0
      t.integer :chapter_id, :default => 0
      
    end
    add_foreign_key :chapter_statuses, :course_enrollments
  end
end
