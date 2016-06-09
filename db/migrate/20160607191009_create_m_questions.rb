class CreateMQuestions < ActiveRecord::Migration
  def change
    create_table :m_questions do |t|
      t.references :questionnaire, index: true
      t.references :answer, index: true
      t.text :text

      t.timestamps null: false
    end
    add_foreign_key :m_questions, :questionnaires
    add_foreign_key :m_questions, :answers
  end
end
