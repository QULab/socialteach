class Chapter < ActiveRecord::Base

  belongs_to :course
  has_many :activities

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
  #validates :tier, numericality: {greater_than_or_equal_to: 0}
  validate :validate_predecessors
  validate :validate_tier

  before_validation :assign_tier
  after_save :update_successor_tiers

  # returns a list of all chapters, that are valid predecessors for this chapter
  def valid_predecessors
    return if tier_update_in_progress?

    succ_min = self.successors.order(tier: :asc).first

    course_chapters = self.course.chapters.where.not(id: self.id).to_a
    unless succ_min.nil?
      course_chapters.select! do |chapter|
        chapter.tier < succ_min.tier
      end
    end
    course_chapters
  end

  def signal_tier_update
    @tier_update_in_progress = true
  end

  def tier_update_in_progress?
    @tier_update_in_progress
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
    if self.tier.present? and succ_min.present? and succ_min.tier <= self.tier
      errors.add(:base, "Tier may not be higher than successor's tier")
    end
  end

  def assign_tier
    max_pred = self.predecessors.order(tier: :desc).first
    min_succ = self.successors.order(tier: :asc).first
    if max_pred.nil?
      if min_succ.present?
        Rails.logger.info("#{self.name}: min succ is #{min_succ.name} with a tier of #{min_succ.tier}")
        self.tier = min_succ.tier - 1
      else
        Rails.logger.info("#{self.name}: no succ or pred found, assigning tier 0")
        self.tier = 0
      end
    else
      Rails.logger.info("#{self.name}: max pred is #{max_pred.name} with a tier of #{max_pred.tier}")
      self.tier = max_pred.tier + 1
    end
  end

  def update_successor_tiers
    self.successors.each do |chapter|
      chapter.send(:assign_tier)
      chapter.signal_tier_update
      chapter.save!
    end
  end
end
