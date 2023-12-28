class AddTawkCodeToSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :settings, :tawk_code, :text
  end
end
