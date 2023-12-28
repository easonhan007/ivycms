class AddCfConfigToSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :settings, :cf_site_key, :string
    add_column :settings, :cf_secret_key, :string
  end
end
