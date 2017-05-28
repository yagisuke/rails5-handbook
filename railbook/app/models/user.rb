class User < ApplicationRecord
  has_secure_password
  
  validates :email, presence: { if: '!dm.blank?' }
  validates :email, confirmation: { on: :create }
  validates :agreement,
    acceptance: { on: :create }

  has_one :author
  has_many :reviews
  has_many :books, through: :reviews
end
