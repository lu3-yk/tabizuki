class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.integer :user_id,     null: false
      t.integer :tweet_id,    null: false

      t.timestamps
    end
  end
end
