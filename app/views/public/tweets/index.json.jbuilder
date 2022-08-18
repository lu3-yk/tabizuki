json.array! @children do |child|
  json.id child.id
  json.name child.name
  json.prefecture_count child.tweets.count
end
