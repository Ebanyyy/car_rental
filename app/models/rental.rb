class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :car

  after_create :calculate_duration
  after_create :calculate_total_price


   enum :status, { pending: 0, success: 1, cancel: 2 }

  def is_pending?
    status == 'pending'
  end

  def is_success?
    status == 'success'
  end

  def is_cancel?
    status == 'cancel'
  end

  def calculate_duration
    self.duration = (drop_off.to_date - pick_up.to_date).to_i 
    self.save
  end

  def calculate_total_price
    self.total_price = duration * car.price 
    self.save
  end

end
