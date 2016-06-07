class CreateCompletedMCQuestions < ActiveRecord::Migration
  def change
    create_table :completed_m_c_questions do |t|
      t.references :m_c_question, index: true
      t.references :answer, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :completed_m_c_questions, :m_c_questions
    add_foreign_key :completed_m_c_questions, :answers
    add_foreign_key :completed_m_c_questions, :users
  end
end
