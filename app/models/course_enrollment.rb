class CourseEnrollment < ActiveRecord::Base
  has_merit

  belongs_to :user
  belongs_to :course
  has_many :activity_statuses
  has_many :chapter_statuses
  belongs_to :current_chapter, class_name: 'Chapter', foreign_key: 'current_chapter_id'
  has_many :owned_badges
  has_many :course_badges, through: :owned_badges

  belongs_to :level

  after_save :set_level
  after_update :set_level

  RECOMMENDATION_NUM = 5

  def set_level
  	level = Level.where("level_pass <= ?", self.points(category: "Levelpoints")).order(:level_pass).reverse.first
  	if level != self.level
  		return self.update(level:level)
  	end
  	return false
  end

  def progress
  	finished_activities = self.activity_statuses.where(is_completed: true, status: 1).select(:activity_id).distinct.count
  	total_activities = self.course.activities.distinct.count
  	return {:finished_activities => finished_activities, :total_activities => total_activities, :percent => finished_activities.to_f/total_activities.to_f}
  end

  def recommended_activities

    chapters = []

    unless self.current_chapter.nil?
      chapters.push(self.current_chapter)
    else
      tier = self.course.chapters.order(:tier).first.tier
      self.course.chapters.where(tier: tier).each {|chapter| chapters.push(chapter)}
    end

    recommended = []

    chapters.each do |chapter|
      chapter_status = self.chapter_statuses.find_by(chapter: chapter)
      chapter_activities = chapter.activities.order(:tier)

      case chapter_status.difficultyFit

      # good fit
      when -0.9...0.9
        # recommend activities of the current chapter
        recommended += unfinished_activities(chapter)

        # additionally recommend activities of following chapter(s) if not enough activities
        recommended += successor_activities(chapter) if recommended.length < RECOMMENDATION_NUM
        successors = chapter.successors
        while recommended.length < RECOMMENDATION_NUM && !successors.empty? do
          next_successors = []
          successors.each do |successor|
            recommended += successor_activities(successor)
            next_successors += successor.successors
          end
          successors = next_successors
        end

      # too hard
      when -Float::INFINITY...-0.9
        recommended += repeatable_activities(chapter)
        # Recommend from earlier chapters if not enough activities
        predecessors = chapter.predecessors
          while recommended.length < RECOMMENDATION_NUM && !predecessors.empty?
            next_predecessors = []
            predecessors.each do |predecessor|
              recommended += unfinished_activities(predecessor)
              next_predecessors += predecessor.predecessors
            end
            predecessors.each do |predecessor|
              recommended += repeatable_activities(predecessor)
            end
            predecessors = next_predecessors
          end

      # too easy
      when 0.9..Float::INFINITY
        recommended += successor_activities(chapter)
        successors = chapter.successors
        while recommended.length < RECOMMENDATION_NUM && !successors.empty?
          next_successors = []
          successors.each do |successor|
            recommended += successor_activities(successor)
            next_successors += successor.successors
          end
          successors = next_successors
        end
      end
    end
    recommended.slice(0, RECOMMENDATION_NUM).uniq
  end

  # fallback: recommend unfinished activities from the whole course
  def recommend_unfinished
    recommend = []
    self.course.chapters.order(:tier).reverse.each do |chapter|
      recommend += unfinished_activities(chapter)
    end

    recommend.slice(0, RECOMMENDATION_NUM).uniq
  end

  def next_level
    next_l = Level.where("level_pass > ?", self.level.level_pass).order(:level_pass).first
    next_pass = self.points(category: "Levelpoints")
    percent = 100
    if next_l.present?
      next_pass = next_l.level_pass
      percent = ((self.points(category: "Levelpoints") - self.level.level_pass ).to_f/(next_pass - self.level.level_pass).to_f * 100).to_i
    end
    
    return {:next_pass => next_pass, :percent => percent}
  end

  private

  # unfinished (unlocked) activities sorted by tier, difficulty
  def unfinished_activities(chapter)
    unfinished_activities = []
    chapter.activities.each do |activity|
      status = self.activity_statuses.find_by(activity: activity)
      unless activity.locked?(self.user) || (!status.nil? && status.is_completed)
        unfinished_activities.push(activity)
      end
    end

    unfinished_activities.sort_by{|activity| [activity.tier, activity.difficulty]}
  end

  # completed activities (lectures, exercises), sorted desc by tier, (success/failed), difficulty
  def repeatable_activities(chapter)
    repeatable_activities = []
    chapter.activities.each do |activity|
      status = self.activity_statuses.find_by(activity: activity)
      next if status.nil?
      if status.is_completed && !activity.content.is_a?(ActivityAssessment)
        repeatable_activities.push(activity)
      end
    end
    repeatable_activities.sort_by{|activity| [activity.tier,
                                              self.activity_statuses.find_by(activity: activity).status,
                                              activity.difficulty]}
  end

  # unlocked activities of predecessors sorted desc by tier, completed, difficulty
  def predecessor_activities(chapter)
    predecessor_activities = []
    chapter.predecessors.each do |predecessor|
      predecessor.activities do |activity|
        predecessor_activities.push(activity) unless activity.locked?(self.user)
      end
    end
    predecessor_activities.sort_by{|activity| [-activity.tier,
                                               self.activity_statuses.find_by(activity: activity).is_completed.to_s,
                                               -activitiy.difficulty]}
  end

  # unlocked activities of unlocked successors sorted by tier, difficulty
  def successor_activities(chapter)
    successor_activities = []
    chapter.successors.each do |successor|
      next if successor.locked?(self.user)
      successor.activities.each do |activity|
        successor_activities.push(activity) unless activity.locked?(self.user)
      end
    end
    successor_activities.sort_by{|activity| [activity.tier, activity.difficulty]}
  end
end
