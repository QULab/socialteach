class CreateDifficultyFeedbacks < ActiveRecord::Migration
  def change
    create_table :difficulty_feedbacks do |t|
      t.references :questionnaire, index: true
      
      t.timestamps null: false
    end
  end
end
