module Merit
  class Score < ActiveRecord::Base
    def self.top_scored_enrolled(options = {})
      options[:since_date] ||= 0
      options[:limit]      ||= 18446744073
      options[:id]         ||= 1

      enrollment_points = CourseEnrollment.all.map do |enrollment|
        if enrollment.is_visible? and enrollment.course_id == options[:id]
          points = enrollment.score_points(category: "Levelpoints").where("created_at > ?", options[:since_date]).sum(:num_points)
          if points > 0
            {:enrollment => enrollment, :points => points}
          end
        end
      end

      enrollment_points = enrollment_points.compact.sort_by {|v| v[:points]}
      enrollment_points = enrollment_points.reverse.take(options[:limit])
      
      enrollment_points
    end
  end
end