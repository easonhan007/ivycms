class CreateNavigations < ActiveRecord::Migration[7.1]
  def change
    create_table :navigations do |t|
      t.string :name
      t.string :link
      t.boolean :dropdown, default: false
      t.integer :sorting, default: 1

      t.timestamps
    end
  end
end
