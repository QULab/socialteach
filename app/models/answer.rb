class Answer < ActiveRecord::Base
  belongs_to :m_question
  # can be the correct answer of a question
  has_one :m_question_answered, class_name: "MQuestion", foreign_key: "correct_answer_id"
  has_many :completed_m_questions
end
