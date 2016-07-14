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

  validates :name, :shortname, :chapter, presence: true
  validates :levelpoints, numericality: {greater_than_or_equal_to: 0}

  validate :validate_tier
  validate :validate_predecessors

  before_validation :assign_tier

  def valid_predecessors
    chapter_activities = self.chapter.activities.where.not(id: self.id).to_a
    chapter_activities.select! do |activity|
      activity.tier.present?
    end

    unless self.tier.present?
      return chapter_activities
    end

    succ_min = self.successors.order(tier: :asc).first

    unless succ_min.nil?
      chapter_activities.select! do |activity|
        activity.tier < succ_min.tier - 1
      end
    end
    chapter_activities
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

  ##
  # checks if this activity is locked for the given user
  # locked activities are those, where the user has not completed the necessary requirements
  def locked?(user)
    predecessors = self.predecessors.to_a
    # if there are no predecessors, the activity is not locked
    locked = predecessors.present?
    completed_predecessors = 0
    predecessors.each do |pred|
      status = pred.activity_statuses.where(is_completed: true).first
      if status.present?
        completed_predecessors += 1
      end
    end
    if completed_predecessors == predecessors.size
      locked = false
    end
    locked
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

  def validate_tier
    succ_min = self.successors.order(tier: :asc).first
    max_pred = self.predecessors.order(tier: :desc).first
    if self.tier.present? and succ_min.present? and succ_min.tier <= self.tier
      errors.add(:base, "Tier may not be higher than or equal to successor's tier")
    elsif self.tier.present? and max_pred.present? and max_pred.tier >= self.tier
      errors.add(:base, "Tier may not be lower than or equal to predecessor's tier")
    end
  end

  def validate_predecessors
    invalid = self.predecessors.to_a - valid_predecessors.to_a
    if invalid.present?
      errors.add(:base, "contains invalid activities")
    end
  end

  def assign_tier
    if self.tier.present?
      return
    end
    max_pred = self.predecessors.order(tier: :desc).first
    if !max_pred.nil?
      if max_pred.tier.present?
        self.tier = max_pred.tier + 1
      end
    end
  end

end
