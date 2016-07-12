class RemoveCorrectAnswerIdFromMQuestions < ActiveRecord::Migration
  def change
    remove_column :m_questions, :correct_answer_id
  end
end
