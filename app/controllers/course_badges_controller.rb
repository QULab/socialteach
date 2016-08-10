class CourseBadgesController < ApplicationController
  before_action :set_course_badge, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  ##
  # Shows finshed and unfished badges
  #-------------------
  # GET courses/course_id/course_badges
  def index
    @course_badges_finished = current_user.get_enrollment(Course.where(id: params[:course_id]).first).course_badges
    @course_badges_unfinished = CourseBadge.where(course_id: params[:course_id]) - @course_badges_finished
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_badge
      @course_badge = CourseBadge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_badge_params
      params.require(:course_badge).permit(:badge, :description, :course_id)
    end
end
