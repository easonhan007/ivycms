class AddIsMdToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :is_md, :boolean, default: false
    add_column :posts, :md_content, :text
  end
end
