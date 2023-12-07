class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :meta_title
      t.string :name
      t.string :key
      t.string :desc
      t.text :specs
      t.string :model_string
      t.text :content
      t.string :price
      t.string :url
      t.boolean :new_arrive, default: true
      t.integer :sorting, default: 1
      t.integer :hot, default: true
      t.boolean :active, default: true
      t.boolean :recommend, default: true
      t.integer :category_id
      t.index :category_id

      t.timestamps
    end
  end
end
