class Chapter < ActiveRecord::Base

  belongs_to :course
  has_many :activities
  has_many :course_enrollments, foreign_key: "current_chapter_id"
  has_many :chapter_statuses

  has_and_belongs_to_many :successors,
    class_name: 'Chapter',
    join_table: :chapter_edges,
    foreign_key: :tail_id,
    association_foreign_key: :head_id,
    uniq: true

  has_and_belongs_to_many :predecessors,
    class_name: 'Chapter',
    join_table: :chapter_edges,
    foreign_key: :head_id,
    association_foreign_key: :tail_id,
    uniq: true

  validates :name, :shortname, :course, presence: true
  validate :validate_predecessors
  validate :validate_tier

  before_validation :assign_tier

  # returns a list of all chapters, that are valid predecessors for this chapter
  def valid_predecessors
    course_chapters = self.course.chapters.where.not(id: self.id).to_a
    course_chapters.select! do |chapter|
      chapter.tier.present?
    end

    unless self.tier.present?
      return course_chapters
    end

    succ_min = self.successors.order(tier: :asc).first

    unless succ_min.nil?
      course_chapters.select! do |chapter|
        chapter.tier < succ_min.tier - 1
      end
    end
    course_chapters
  end

  # whether the given user completed all actvities of the chapter
  def completed?(user)
    course_enrollment = self.course.course_enrollments.find_by(user: user)

    self.activities.all? do |activity|
      statuses = activity.activity_statuses
      statuses.exists?(course_enrollment: course_enrollment) &&
        statuses.find_by(course_enrollment: course_enrollment).is_completed
    end
  end

  def get_status(user)
    course_enrollment = self.course.course_enrollments.find_by(user: user)
    self.chapter_statuses.find_by(course_enrollment: course_enrollment)
  end

  ##
  # checks if this chapter is locked for the given user
  # locked chapters are those, where the user has not completed the necessary requirements
  def locked?(user)
    predecessors = self.predecessors.to_a
    enrollment = CourseEnrollment.where("user_id = ? AND course_id = ?", user.id, self.course.id).first
    # if there are no predecessors, the chapter is not locked
    locked = predecessors.present?
    completed_predecessors = enrollment.chapter_statuses.where("finished = ? OR skip = ?", true, true).count
    if completed_predecessors == predecessors.size
      locked = false
    end
    locked
  end


  private

  def validate_predecessors
    invalid = self.predecessors.to_a - valid_predecessors.to_a
    if invalid.present?
      errors.add(:base, "contains invalid chapters")
    end
  end

  def validate_tier
    succ_min = self.successors.order(tier: :asc).first
    max_pred = self.predecessors.order(tier: :desc).first
    if self.tier.present? and succ_min.present? and succ_min.tier <= self.tier
      errors.add(:base, "Tier may not be higher than or equal to successor's tier")
    elsif self.tier.present? and max_pred.present? and max_pred.tier >= self.tier
      errors.add(:base, "Tier may not be lower than or equal to predecessor's tier")
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
