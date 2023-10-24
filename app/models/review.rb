class Review < ApplicationRecord
  belongs_to :user
  belongs_to :car 

  validates :rating, presence: true
  validates :comment, presence: true, length: {maximum: 500}

  def blank_star
    5 - rating.to_i
  end
end
