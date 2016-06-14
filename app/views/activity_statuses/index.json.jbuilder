json.array!(@activity_statuses) do |activity_status|
  json.extract! activity_status, :id, :is_completed, :Status, :Activity, :Course_enrollment
  json.url activity_status_url(activity_status, format: :json)
end
