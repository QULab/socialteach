json.array!(@leaderboards) do |leaderboard|
  json.extract! leaderboard, :id
  json.url leaderboard_url(leaderboard, format: :json)
end
