class CreateSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :settings do |t|
      t.string :name
      t.string :url
      t.string :logo
      t.string :ico
      t.text :copyright
      t.string :email
      t.string :skype
      t.string :whatsapp
      t.string :phone
      t.integer :product_per_page
      t.integer :post_per_page
      t.integer :recommend_per_page
      t.text :share_code
      t.string :email_user_name
      t.string :email_password
      t.string :email_port
      t.string :email_smtp
      t.string :email_receiver
      t.string :email_sender
      t.boolean :email_active, default: false
      t.text :ga_code

      t.timestamps
    end
  end
end
