class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.string :pick_up_location
      t.string :drop_off_location
      t.datetime :pick_up
      t.datetime :drop_off
      t.integer :duration, default: 0
      t.boolean :confirmed, default: true
      t.decimal :total_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
