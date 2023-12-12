class AddAutoSslAndAuthenticationToSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :settings, :email_auto_ssl, :boolean, default: true
    add_column :settings, :email_authentication, :boolean, default: true
  end
end
