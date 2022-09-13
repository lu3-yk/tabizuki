class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true
      t.references :subject, polymorphic: true
      t.integer :action_type, null: false
      t.boolean :read, null: false, default: false
      t.timestamps
    end
  end
end
