class CompletedQuestionnaire < ActiveRecord::Base
  belongs_to :questionnaire
  belongs_to :user

  has_many :completed_m_questions

  def score
    count = self.completed_m_questions.count
    return 1 if count == 0
    correct = 0
    self.completed_m_questions.each do |question|
      correct += 1 if question.correct?
    end
    correct.to_f / count.to_f
  end

  def passed?
    self.score > 0.8
  end

  def propose_chapter_skip?
    self.score > 0.95
  end
end
