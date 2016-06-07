class CreateQuestionnaires < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|
      t.integer :qu_container_id # foreign key
      t.string :qu_container_type # associated model (difficulty_feedback or activity)

      t.timestamps null: false
    end
  end
end
