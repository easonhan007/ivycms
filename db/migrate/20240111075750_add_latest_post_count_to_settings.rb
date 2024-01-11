class AddLatestPostCountToSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :settings, :latest_post_count, :integer, default: 3
  end
end
