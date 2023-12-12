class AlterProductsHotField < ActiveRecord::Migration[7.1]
  def change
    change_column :products, :hot, :boolean, default: true
  end
end
