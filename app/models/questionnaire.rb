class Questionnaire < ActiveRecord::Base
  has_many :m_questions
  has_many :completed_questionnaires

  # feedback, assessment, or excercise
  belongs_to :qu_container, polymorphic: true
end
