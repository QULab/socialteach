json.array!(@course_badges) do |course_badge|
  json.extract! course_badge, :id, :badge, :description
  json.url course_badge_url(course_badge, format: :json)
end
