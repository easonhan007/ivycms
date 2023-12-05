class AddSortingToDownloadFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :download_files, :sorting, :integer, default: 1
  end
end
