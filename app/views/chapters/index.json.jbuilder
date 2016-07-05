json.array!(@chapters) do |chapter|
  json.extract! chapter, :id, :name, :shortname, :description
  json.url chapter_url(chapter, format: :json)
end
