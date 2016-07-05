class ActivityStatus < ActiveRecord::Base
	belongs_to :activity
	belongs_to :course_enrollment
	belongs_to :learningpoints, :class_name => "Merit::Score::Point"
	belongs_to :levelpoints, :class_name => "Merit::Score::Point"

	after_save :create_points
	after_update :create_points

	def create_points
		if self.is_completed?
			if self.learningpoints_id == nil
				if self.status == 1
					levelpoints = self.course_enrollment.add_points(self.activity.levelpoints, category: "Levelpoints")
				else
					levelpoints = self.course_enrollment.add_points(0, category: "Levelpoints")
				end
				learningpoints = self.course_enrollment.user.add_points(1,category: "Learningpoints")
				self.update(learningpoints: learningpoints, levelpoints: levelpoints)

				self.course_enrollment.set_level
			end
		end
	end
end
