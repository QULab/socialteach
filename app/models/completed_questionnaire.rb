class CompletedQuestionnaire < ActiveRecord::Base
  belongs_to :questionnaire
  belongs_to :user

  has_many :completed_m_questions
end
