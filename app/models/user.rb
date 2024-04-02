class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :notificaitons, dependent: :destroy
end
