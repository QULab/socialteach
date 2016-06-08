class Questionnaire < ActiveRecord::Base
  has_many :mc_questions
  has_many :completed_questionnaires

  # difficulty_feedback, assessment, or excercise
  belongs_to :qu_container, polymorphic: true
end
