class CreateFriendLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :friend_links do |t|
      t.string :name
      t.string :url
      t.integer :sorting, default: 1
      t.string :image

      t.timestamps
    end
  end
end
