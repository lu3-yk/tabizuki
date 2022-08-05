class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.integer :prefecture_id
      t.string  :title,       null: false
      t.string  :body,        null: false
      t.timestamps
    end
  end
end
