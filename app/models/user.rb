class User < ApplicationRecord
  has_secure_password

  validates :phone_number, phone: true
  validates :email, :phone_number, uniqueness: true, presence: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  has_many :orders, dependent: :destroy
  has_many :notificaitons, dependent: :destroy
end
