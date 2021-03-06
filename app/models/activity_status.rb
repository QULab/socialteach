class ActivityStatus < ActiveRecord::Base
	belongs_to :activity
	belongs_to :course_enrollment
	belongs_to :learningpoints, :class_name => "Merit::Score::Point"
	belongs_to :levelpoints, :class_name => "Merit::Score::Point"

	after_save :create_points_badges
	after_update :create_points_badges

	def create_points_badges
		if self.is_completed?
			if self.learningpoints_id == nil
				user = self.course_enrollment.user
				if self.status == 1
					points = (self.activity.level.level.to_f/self.course_enrollment.level.level.to_f * self.activity.levelpoints).to_i
					levelpoints = self.course_enrollment.add_points(points, category: "Levelpoints")
					self.activity.unlock_course_badges.each do |badge|
						course_badge = badge.course_badge
						if self.course_enrollment.course_badges.exclude?(course_badge)
							all_completed = true
							course_badge.unlock_course_badges.each do |unlock|
								if !unlock.activity.activity_statuses.exists?(course_enrollment: self.course_enrollment)
									all_completed = false
								end
							end
							if all_completed
								OwnedBadge.create(course_enrollment: self.course_enrollment, course_badge: course_badge)
							end
						end
					end
				else
					levelpoints = self.course_enrollment.add_points(0, category: "Levelpoints")
				end
				learningpoints = user.add_points(1,category: "Learningpoints")
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
		1
	end

	def self.failed
		-1
	end
end
