class MQuestion < ActiveRecord::Base
  belongs_to :questionnaire
  belongs_to :correct_answer, class: "Answer"
  has_many :answers # possible answers
  has_many :completed_m_questions
end
