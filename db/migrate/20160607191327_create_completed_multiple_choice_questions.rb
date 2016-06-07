class CreateCompletedMultipleChoiceQuestions < ActiveRecord::Migration
  def change
    create_table :completed_multiple_choice_questions do |t|
      t.references :multiple_choice_question, index: true
      t.references :answer, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :completed_multiple_choice_questions, :multiple_choice_questions
    add_foreign_key :completed_multiple_choice_questions, :answers
    add_foreign_key :completed_multiple_choice_questions, :users
  end
end
