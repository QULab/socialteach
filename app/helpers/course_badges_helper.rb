module CourseBadgesHelper
	def setup_course_badge(path)
		position = path.index{|x| x.is_a? CourseBadge}
		coursebadge = path[position]
		(Activity.all - coursebadge.activities).each do |activity|
			coursebadge.unlock_course_badges.build(:activity => activity)
		end
		path = path
	end
end
