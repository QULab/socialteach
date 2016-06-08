class CreateMCQuestions < ActiveRecord::Migration
  def change
    create_table :mc_questions do |t|
      t.references :questionnaire, index: true
      t.references :answer, index: true
      t.text :text

      t.timestamps null: false
    end
    add_foreign_key :mc_questions, :questionnaires
    add_foreign_key :mc_questions, :answers
  end
end
