json.array!(@chapter_statuses) do |chapter_status|
  json.extract! chapter_status, :id, :skip, :course_enrollment_id
  json.url chapter_status_url(chapter_status, format: :json)
end
