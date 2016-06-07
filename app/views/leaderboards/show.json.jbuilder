json.array!(@leaderboard) do |user|
  json.extract! user, "username", "sum_points"
end