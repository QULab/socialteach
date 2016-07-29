module CourseBadgesHelper
	def setup_course_badge(path)
		position = path.index{|x| x.is_a? CourseBadge}
		coursebadge = path[position]
		(Activity.all - coursebadge.activities).each_with_index do |activity,i|
			if activity.course.id == coursebadge.course_id and coursebadge.unlock_course_badges.select {|x| x.activity_id == activity.id}.empty?
				coursebadge.unlock_course_badges.build(:activity => activity)
			end
		end
		path = path
	end
end
