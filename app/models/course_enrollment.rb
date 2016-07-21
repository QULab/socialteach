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

  def next_level
    next_pass = Level.where("level_pass > ?", self.level.level_pass).order(:level_pass).first.level_pass
    percent = ((self.points(category: "Levelpoints") - self.level.level_pass ).to_f/(next_pass - self.level.level_pass).to_f * 100).to_i
    return {:next_pass => next_pass, :percent => percent}
  end
end
