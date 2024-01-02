class AddGTagCodeToSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :settings, :g_tag_head, :text
    add_column :settings, :g_tag_body, :text
  end
end
