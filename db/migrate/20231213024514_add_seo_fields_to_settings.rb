class AddSeoFieldsToSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :settings, :seo_meta_title, :string
    add_column :settings, :seo_keywords, :string
    add_column :settings, :seo_description, :string
  end
end
