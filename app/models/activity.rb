class Activity < ApplicationRecord
  # _pathをモデルで使用する場合は、Helperを呼び出す必要がある。
  include Rails.application.routes.url_helpers

  belongs_to :subject, polymorphic: true
  belongs_to :user

  enum action_type: {
    liked_to_tweet: 0,followed_me: 1,commented_to_tweet: 2
  }
  enum read: { unread: false, read: true }

  # リダイレクトのパスをenumをもとにして生成する
  def redirect_path
    case self.action_type.to_sym
    when :liked_to_tweet
      tweet_path(self.subject.tweet)
    when :followed_me
      user_path(self.subject.user)
    when :commented_to_tweet
      tweet_path(self.subject.tweet)
    end
  end
  
end
