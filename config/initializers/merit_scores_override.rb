module Merit
  class Score < ActiveRecord::Base
    def self.top_scored_enrolled(options = {})
      options[:since_date] ||= 0
      options[:limit]      ||= 18446744073
      options[:id]         ||= 1
      options[:category]   ||= 'Levelpoints'

      c_enrollment = :course_enrollments

      alias_id_column = "#{c_enrollment.to_s.singularize}_id"
      if options[:table_name] == :sashes
        sash_id_column = "#{c_enrollment}.id"
      else
        sash_id_column = "#{c_enrollment}.sash_id"
      end

      # MeritableModel - Sash -< Scores -< ScorePoints
      sql_query = <<SQL
SELECT
  users.username AS username,
  SUM(num_points) as sum_points
FROM #{c_enrollment}
  LEFT JOIN merit_scores ON merit_scores.sash_id = #{sash_id_column}
  LEFT JOIN merit_score_points ON merit_score_points.score_id = merit_scores.id
  INNER JOIN users ON #{c_enrollment}.user_id = users.id
WHERE merit_score_points.created_at > #{options[:since_date]}
  AND is_visible = 't' AND active = 't' AND course_id = #{options[:id]}
  AND category = '#{options[:category]}'
GROUP BY #{c_enrollment}.id, merit_scores.sash_id
ORDER BY sum_points DESC
LIMIT #{options[:limit]}
SQL
      results = ActiveRecord::Base.connection.execute(sql_query)
      results.map do |h|
        h.keep_if { |k, v| (k == 'user') || (k == 'sum_points') }
      end
      results
    end
  end
end