class User < ApplicationRecord
  has_secure_password

  validates :phone_number, phone: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, :phone_number, uniqueness: true, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: ->(record) { record.new_record? || record.password.present? || record.password_confirmation.present?  }

  has_many :orders, dependent: :destroy

  enum role: %i(default administrator)

  def self.ransackable_associations(auth_object = nil)
    ["notificaitons", "orders"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "full_name", "id", "id_value", "password_digest", "phone_number", "role", "uniq_hash", "updated_at"]
  end
end
