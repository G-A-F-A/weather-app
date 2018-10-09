class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.integer :session_user_id
      t.string :place
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
