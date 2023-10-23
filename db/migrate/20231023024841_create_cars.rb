class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.references :user, null: false, foreign_key: true
      t.string :car_name
      t.string :category
      t.decimal :price, precision: 10, scale: 2
      t.integer :capacity, default: 0
      t.boolean :available, default: false
      t.decimal :ave_rating, precision: 5, scale: 2

      t.timestamps
    end
  end
end
