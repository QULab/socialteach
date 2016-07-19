module CourseBadgesHelper
	def setup_course_badge(path)
		position = path.index{|x| x.is_a? CourseBadge}
		coursebadge = path[position]
		(Activity.all - coursebadge.activities).each do |activity|
			if activity.course.id == coursebadge.course_id
				puts activity.name
				coursebadge.unlock_course_badges.build(:activity => activity)
			end
		end
		coursebadge.unlock_course_badges.each do |t|
			puts t.activity.name
		end
		path = path
	end
end
