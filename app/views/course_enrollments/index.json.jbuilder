json.array!(@course_enrollments) do |course_enrollment|
  json.extract! course_enrollment, :id, :active, :completed, :is_visible, :is_visible_friends, :user_id, :course_id
  json.url course_enrollment_url(course_enrollment, format: :json)
end
