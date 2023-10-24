class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :car

  after_create :calculate_duration
  after_create :calculate_total_price

  def calculate_duration
    self.duration = (drop_off.to_date - pick_up.to_date).to_i 
    self.save
  end

  def calculate_total_price
    self.total_price = duration * car.price 
    self.save
  end

end
