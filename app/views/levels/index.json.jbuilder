json.array!(@levels) do |level|
  json.extract! level, :id, :level, :level_pass
  json.url level_url(level, format: :json)
end
