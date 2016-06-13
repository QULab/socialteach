class CreateCompletedMQuestions < ActiveRecord::Migration
  def change
    create_table :completed_m_questions do |t|
      t.references :m_question, index: true
      t.references :answer, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :completed_m_questions, :m_questions
    add_foreign_key :completed_m_questions, :answers
    add_foreign_key :completed_m_questions, :users
  end
end
