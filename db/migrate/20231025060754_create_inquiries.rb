class CreateInquiries < ActiveRecord::Migration[7.0]
  def change
    create_table :inquiries do |t|
      t.string :email
      t.text :message_box

      t.timestamps
    end
  end
end
