class CompletedMQuestion < ActiveRecord::Base
  belongs_to :m_question
  has_and_belongs_to_many :answers
  belongs_to :user

  belongs_to :completed_questionnaire
end
