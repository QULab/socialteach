module CourseEnrollmentsHelper
  def user_enrolled?(user, course)
    return CourseEnrollment.where("user_id = ? AND course_id = ?", user.id, course.id).exists?
  end

  def user_enrollment(user, course)
    enrollment = CourseEnrollment.where("user_id = ? AND course_id = ?", user.id, course.id).first
    return enrollment
  end
end
