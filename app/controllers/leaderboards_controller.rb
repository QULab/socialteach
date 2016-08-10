class LeaderboardsController < ApplicationController
  before_action :set_leaderboard, only: [:show]

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Course", :course_path

  # GET /leaderboards/1
  # GET /leaderboards/1.json
  def show
    add_breadcrumb "Leaderboard", leaderboard_path()
    @course = Course.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leaderboard
      time = 0

      if params[:today]
        time = 1.day.ago
      elsif params[:week]
        time = 1.week.ago
      elsif params[:month]
        time = 1.month.ago
      end
      
      if params[:friends]
        @leaderboard = top_scored_friends(id: params[:id].to_i,since_date: time)
        @friends = params[:friends]
      else
        @leaderboard = Merit::Score.top_scored_enrolled(id: params[:id].to_i,since_date: time)
      end
    end

    # Get leaderboard in context of user
    def top_scored_friends(options = {})
      options[:since_date] ||= 0
      options[:limit]      ||= 184
      options[:id]         ||= 1

      enrollment_points = current_user.friends.map do |friend|
        out_enrollment = nil
        out_points = nil
        friend.course_enrollments.each do |enrollment|
          if enrollment.is_visible_friends? and enrollment.course_id == options[:id]
            points = enrollment.score_points(category: "Levelpoints").where("created_at > ?", options[:since_date]).sum(:num_points)
            if points > 0
              out_enrollment = enrollment
              out_points = points
            end
          end
        end
        {enrollment: out_enrollment, points: out_points}
      end

      enrollment_points = enrollment_points.compact.sort_by {|v| v[:points]}
      enrollment_points = enrollment_points.reverse.take(options[:limit])
      
      enrollment_points
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leaderboard_params
      params.fetch(:leaderboard, {})
    end
end
