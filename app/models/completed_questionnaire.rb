##
# Represents a completed questionnaire for a user. Contains completed questions.
class CompletedQuestionnaire < ActiveRecord::Base
  belongs_to :questionnaire
  belongs_to :user

  has_many :completed_m_questions

  ##
  # The score reached by the answers given in this completed questionnaire.
  def score
    count = self.completed_m_questions.count
    return 1 if count == 0
    correct = 0
    self.completed_m_questions.each do |question|
      correct += 1 if question.correct?
    end
    correct.to_f / count.to_f
  end

  ##
  # Whether the corresponding questionnaire is passed with the score.
  def passed?
    self.score > 0.8
  end

  ##
  # Whether the user should be proposed to skip the chapter.
  def propose_chapter_skip?
    self.score > 0.95
  end
end
