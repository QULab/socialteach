class MQuestion < ActiveRecord::Base
  belongs_to :questionnaire
  belongs_to :correct_answer, class_name: "Answer", :foreign_key => 'correct_answer_id'
  has_many :answers # possible answers
  has_many :completed_m_questions
end