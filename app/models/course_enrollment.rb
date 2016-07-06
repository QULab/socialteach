class CourseEnrollment < ActiveRecord::Base
  has_merit

  belongs_to :user
  belongs_to :course
  has_many :activity_statuses
  has_many :owned_badges
  has_many :course_badges, through: :owned_badges

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
end
