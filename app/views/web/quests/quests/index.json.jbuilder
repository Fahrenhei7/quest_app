json.array!(@quests) do |quest|
  json.extract! quest, :id, :name, :description, :user_id
  json.url quest_url(quest, format: :json)
end
