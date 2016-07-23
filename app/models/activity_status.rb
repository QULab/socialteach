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
					points = (self.activity.level.level.to_f/self.course_enrollment.level.level.to_f * self.activity.levelpoints).to_i
					levelpoints = self.course_enrollment.add_points(points, category: "Levelpoints")
				else
					levelpoints = self.course_enrollment.add_points(0, category: "Levelpoints")
				end
				learningpoints = self.course_enrollment.user.add_points(1,category: "Learningpoints")
				self.update(learningpoints: learningpoints, levelpoints: levelpoints)

				self.course_enrollment.set_level
				Merit::Badge.all.each do |general_badge|
					user = self.course_enrollment.user
					if user.badges.exclude?(general_badge)
						fields = general_badge.custom_fields
						if fields[:type] == :learning and fields[:condition] <= user.points(category: "Learningpoints")
							user.add_badge(general_badge.id)
						elsif fields[:type] == :activities and fields[:condition] <= course_enrollment.activity_statuses.where(is_completed: true, status: 1).count
							user.add_badge(general_badge.id)
						end
					end
				end
			end
		end
	end

	def self.successfull
		2
	end

	def self.failed
		-1
	end
end
