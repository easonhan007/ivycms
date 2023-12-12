class AddContentToCategory < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :content, :text
  end
end
