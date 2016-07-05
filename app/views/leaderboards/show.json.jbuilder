json.array!(@leaderboard) do |enrollment|
  json.extract! enrollment, :enrollment, :points
end