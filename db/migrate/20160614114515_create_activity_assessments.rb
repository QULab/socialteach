class CreateActivityAssessments < ActiveRecord::Migration
  def change
    create_table :activity_assessments do |t|

      t.timestamps null: false
    end
  end
end
