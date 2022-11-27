json.tweets do
  json.array! @tweets do |tweet|
    json.id         tweet.id
    json.user       tweet.user
    json.content    tweet.content
    json.created_at tweet.created_at
  end
end
