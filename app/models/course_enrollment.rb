class CourseEnrollment < ActiveRecord::Base
  has_merit

  belongs_to :user
  belongs_to :course
  has_many :activity_statuses
  has_many :chapter_statuses
  belongs_to :current_chapter, class_name: 'Chapter', foreign_key: 'current_chapter_id'

  belongs_to :level

  after_save :set_level
  after_update :set_level

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
    recommendation_num = 5

    chapter = unless self.current_chapter.nil?
                self.current_chapter
              else
                self.course.chapters.order(:tier).first
              end

    chapter_status = self.chapter_statuses.find_by(chapter: chapter)
    chapter_activities = chapter.activities.order(:tier)

    recommended = []
    case chapter_status.difficultyFit

    # good fit
    when -0.9...0.9
      # recommend activities of the current chapter
      recommended += unfinished_activities(chapter)

      # additionally recommend activities of following chapter(s) if not enough activities
      recommended += successor_activities(chapter) if recommended.length < recommendation_num
      successors = chapter.successors
      while recommended.length < recommendation_num && !successors.empty? do
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
        while recommended.length < recommendation_num && !predecessors.empty?
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
      while recommended.length < recommendation_num && !successors.empty?
        next_successors = []
        successors.each do |successor|
          recommended += successor_activities(successor)
          next_successors += successor.successors
        end
        successors = next_successors
      end
    end
    recommended.slice(0, recommendation_num).uniq
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

  # activities of predecessors sorted desc by tier, completed, difficulty
  def predecessor_activities(chapter)
    predecessor_activities = []
    chapter.predecessors.each do |predecessor|
      predecessor_activities += predecessor.activities
    end
    predecessor_activities.sort_by{|activity| [-activity.tier,
                                               self.activity_statuses.find_by(activity: activity).is_completed.to_s,
                                               -activitiy.difficulty]}
  end

  # activities of unlocked successors sorted by tier, difficulty
  def successor_activities(chapter)
    successor_activities = []
    chapter.successors.each do |successor|
      next if successor.locked?(self.user)
      successor_activities += successor.activities
    end
    successor_activities.sort_by{|activity| [activity.tier, activity.difficulty]}
  end
end
