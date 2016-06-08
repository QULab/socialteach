class Answer < ActiveRecord::Base
  belongs_to :mc_question
  # can be the correct answer of a question
  has_one :mc_question_answered, class_name: "MCQuestion", foreign_key: "correct_answer_id"
  has_many :completed_mc_questions
end
