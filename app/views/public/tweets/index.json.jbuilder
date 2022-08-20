json.array! @children do |child|
  json.id child.id
  json.name child.name
  if @user.present?
    json.prefecture_count child.tweets.where(user: @user).count
  else
    json.prefecture_count child.tweets.count
  end
end
