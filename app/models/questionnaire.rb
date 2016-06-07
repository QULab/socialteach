class Questionnaire < ActiveRecord::Base
  has_many :multiple_choice_questions
  belongs_to :qu_container, polymorphic: true # difficulty_feedback, assessment, or questionnaire
end
