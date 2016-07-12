class CompletedQuestionnaire < ActiveRecord::Base
  belongs_to :questionnaire
  belongs_to :user

  has_many :completed_m_questions

  def score
    count = self.completed_m_questions.count
    correct = 0
    self.completed_m_questions.each do |question|
      correct += 1 if question.correct?
    end
    100 * correct / count
  end

  def passed?
    self.score > 50
  end
end
