class AddNewArrivePerPageToSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :settings, :new_arrive_per_page, :integer
  end
end
