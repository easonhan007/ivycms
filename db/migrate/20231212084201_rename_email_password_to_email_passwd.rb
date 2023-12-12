class RenameEmailPasswordToEmailPasswd < ActiveRecord::Migration[7.1]
  def change
    rename_column :settings, :email_password, :email_passwd
  end
end
