class CreateSuggestions < ActiveRecord::Migration[5.0]
  def change
    create_table :suggestions do |t|
      t.string :title
      t.string :description
      t.string :place_id_google
      t.integer :user_id
      t.integer :chatroom_id
      t.index :user_id
      t.index :chatroom_id

      t.timestamps
    end
  end
end
