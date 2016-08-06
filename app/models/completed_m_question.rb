##
# Represents a completed question for a user. Contains the answers given.
class CompletedMQuestion < ActiveRecord::Base
  belongs_to :m_question
  has_and_belongs_to_many :answers
  belongs_to :user

  belongs_to :completed_questionnaire

  ##
  # Whether the answers given by the user are correct and complete.
  def correct?
    unless self.answers.any?{ |answer| !answer.correct }
      return self.m_question.answers.where(correct: true).count == self.answers.where(correct: true).count
    end
      return false
  end
end
