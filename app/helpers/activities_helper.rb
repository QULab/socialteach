module ActivitiesHelper
  def activity_icon(activity)
    return "fa-book" if activity.content.is_a?(ActivityLecture)
    # return "fa-graduation-cap" if activity.content.is_a?(ActivityAssessment)
    # return "fa-check-square-o" if activity.content.is_a?(ActivityExercise)
    return "fa-question"
  end

  def user_completed_activity?(user, activity)
    enrollment = user_enrollment(user, activity.course)
    return ActivityStatus.where("activity_id = ? AND course_enrollment_id = ?", activity.id, enrollment.id).exists?
  end
end
