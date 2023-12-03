class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.integer :level, default: 1
      t.string :path
      t.string :name
      t.string :key
      t.string :description
      t.string :image
      t.string :url
      t.string :type
      t.integer :sorting, default: 1
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
