class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :record, polymorphic: true
      t.references :user
      t.text :content
      t.timestamps
    end
  end
end
