class AddRawBlockToSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :settings, :raw_block, :text
  end
end
