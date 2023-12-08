class AddAltToImages < ActiveRecord::Migration[7.1]
  def change
    add_column :images, :alt, :string
  end
end
