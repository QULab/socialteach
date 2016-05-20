json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :name, :description, :lecture_id
  json.url lesson_url(lesson, format: :json)
end
