class CreateDownloadFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :download_files do |t|
      t.string :name
      t.string :desc

      t.timestamps
    end
  end
end
