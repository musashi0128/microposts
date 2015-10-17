class CreateRetweetships < ActiveRecord::Migration
  def change
    create_table :retweetships do |t|
      t.integer :user_id, null: false
      t.integer :micropost_id, null: false

      t.timestamps null: false
    end
  end
end
