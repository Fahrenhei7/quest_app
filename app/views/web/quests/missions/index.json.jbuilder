json.array!(@missions) do |mission|
  json.extract! mission, :id, :task, :key, :quest, :difficulty
  json.url mission_url(mission, format: :json)
end
