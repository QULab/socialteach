class Answer < ActiveRecord::Base
  belongs_to :multiple_choice_question
  # can be the correct answer of a question
  has_one :multiple_choice_question_answered, class_name: "MultipleChoiceQuestion", foreign_key: "correct_answer_id"
  has_many :completed_multiple_choice_questions
end
