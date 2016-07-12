class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :completed_m_questions, :answers do |t|
      t.index [:completed_m_question_id, :answer_id], name: 'i_answers_c_questions_on_c_question_id_and_answer_id'
      t.index [:answer_id, :completed_m_question_id], name: 'i_answers_c_questions_on_answer_id_and_c_question_id'
    end

    CompletedMQuestion.all.each do | completed_question |
      completed_question.answers << Answer.find(completed_question.answer_id) if completed_question.answer_id
    end

    remove_column :completed_m_questions, :answer_id
  end
end
