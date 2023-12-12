class CreateInquiries < ActiveRecord::Migration[7.1]
  def change
    create_table :inquiries do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :content
      t.string :ip
      t.integer :product_id

      t.timestamps
    end
  end
end
