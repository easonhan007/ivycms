class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :desc
      t.text :content
      t.string :image
      t.string :display_title
      t.integer :category_id

      t.index :category_id

      t.timestamps
    end
  end
end
