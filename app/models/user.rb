class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :cars, dependent: :destroy
  has_many :rentals, dependent: :destroy
  has_many :reviews, dependent: :destroy

  enum :role, { customer: 0, admin: 1 }

  def is_admin?
    role == 'admin'
  end

  def is_customer?
    role == 'customer'
  end
end
