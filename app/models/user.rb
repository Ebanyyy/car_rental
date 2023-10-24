class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :cars, dependent: :destroy
  has_many :rentals, dependent: :destroy
end
