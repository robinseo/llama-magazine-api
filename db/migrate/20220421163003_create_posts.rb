class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user
      t.text :content
      t.integer :layout
      t.integer :likes_count, default: 0
      t.timestamps
    end
  end
end
