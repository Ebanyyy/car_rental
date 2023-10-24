class AddCarReferencesToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :car, null: false, foreign_key: true
  end
end
