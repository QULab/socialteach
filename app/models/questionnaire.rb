class Questionnaire < ActiveRecord::Base
  has_many :multiple_choice_questions
  has_many :completed_questionnaires
end
