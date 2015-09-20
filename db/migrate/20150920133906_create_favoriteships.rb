class CreateFavoriteships < ActiveRecord::Migration
  def change
    create_table :favoriteships do |t|
      t.references :user, null: false
      t.references :micropost, null: false

      t.timestamps null: false
    end
  end
end
