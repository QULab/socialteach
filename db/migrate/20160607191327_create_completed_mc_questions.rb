class CreateCompletedMCQuestions < ActiveRecord::Migration
  def change
    create_table :completed_mc_questions do |t|
      t.references :mc_question, index: true
      t.references :answer, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :completed_mc_questions, :mc_questions
    add_foreign_key :completed_mc_questions, :answers
    add_foreign_key :completed_mc_questions, :users
  end
end
