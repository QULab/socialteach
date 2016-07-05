class Questionnaire < ActiveRecord::Base
  has_many :m_questions, dependent: :destroy
  has_many :completed_questionnaires

  # feedback, assessment, or exercise
  belongs_to :qu_container, polymorphic: true

  accepts_nested_attributes_for :m_questions
end
