class AddTitleToInquiries < ActiveRecord::Migration[7.0]
  def change
    add_column :inquiries, :title, :string
  end
end
