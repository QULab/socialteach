class Activity < ActiveRecord::Base
	after_save :create_default_feedback

	belongs_to :chapter
	has_many :activity_statuses
  belongs_to :level

  belongs_to :content, polymorphic: true
  accepts_nested_attributes_for :content

	has_one :feedback, as: :commentable

  has_and_belongs_to_many :successors,
    class_name: 'Activity',
    join_table: :activity_edges,
    foreign_key: :tail_id,
    association_foreign_key: :head_id,
    uniq: true

  has_and_belongs_to_many :predecessors,
    class_name: 'Activity',
    join_table: :activity_edges,
    foreign_key: :head_id,
    association_foreign_key: :tail_id,
    uniq: true

  validates :name, :shortname, :tier, :chapter, presence: true
  validates :tier, :levelpoints, numericality: {greater_than_or_equal_to: 0}

  validate :validate_predecessors

  before_validation :assign_tier
  after_save :update_successor_tiers

  def valid_predecessors
    return if tier_update_in_progress?

    succ_min = self.successors.order(tier: :asc).first

    chapter_activities = self.chapter.activities.where.not(id: self.id).to_a
    unless succ_min.nil?
      chapter_activities.select! do |chapter|
        chapter.tier < succ_min.tier
      end
    end
    chapter_activities
  end

  def signal_tier_update
    @tier_update_in_progress = true
  end

  def tier_update_in_progress?
    @tier_update_in_progress
  end

  # Update switch statment as soon as other content classes exist!
  def color
    case content
      when ActivityLecture
        "#428CCA" # blue
      when ActivityExercise
        "#CAA82C" # yellow
      when ActivityAssessment
        "#99413F" # red
      else
        "#577B99" # greyish blue
    end
  end

  def course
    chapter.course
  end

	def create_default_feedback
		questionnaire = Questionnaire.create!(qu_container: Feedback.create!(commentable: self))
		question = questionnaire.m_questions.create!(text: 'How difficult was this unit?')
		questionId = question.id
		Answer.create(m_question_id: questionId, text: 'Too Easy')
		Answer.create(m_question_id: questionId, text: 'Perfect Difficulty')
		Answer.create(m_question_id: questionId, text: 'Too Hard')
	end

  private

  def validate_predecessors
    invalid = self.predecessors.to_a - valid_predecessors.to_a
    if invalid.present?
      errors.add(:base, "contains invalid activities")
    end
  end

  def assign_tier
    max_pred = self.predecessors.order(tier: :desc).first
    if max_pred.nil?
      self.tier = 0
    else
      self.tier = max_pred.tier + 1
    end
  end

  def update_successor_tiers
    self.successors.each do |activity|
      activity.send(:assign_tier)
      activity.signal_tier_update
      activity.save!
    end
  end

end
