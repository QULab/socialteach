module CourseEnrollmentsHelper
  def user_enrolled?(course, user)
    enrollment = CourseEnrollment.where("user_id = ? AND course_id = ?", user.id, course.id).first
    return enrollment.exists?
  end
end
