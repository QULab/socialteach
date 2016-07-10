class Activity < ActiveRecord::Base
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

  # returns a list of all activities, that are valid predecessors for this activity
  def valid_predecessors
    chapter_activities = self.chapter.activities.to_a
    predecessors = chapter_activities.select do |act|
      act.tier < self.tier
    end
    return predecessors
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
end
