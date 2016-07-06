class CompletedMQuestion < ActiveRecord::Base
  belongs_to :m_question
  belongs_to :answer
  belongs_to :user

  belongs_to :completed_questionnaire
end
