class CreateMultipleChoiceQuestions < ActiveRecord::Migration
  def change
    create_table :multiple_choice_questions do |t|
      t.references :questionnaire, index: true
      t.references :answer, index: true
      t.text :text

      t.timestamps null: false
    end
    add_foreign_key :multiple_choice_questions, :questionnaires
    add_foreign_key :multiple_choice_questions, :answers
  end
end
