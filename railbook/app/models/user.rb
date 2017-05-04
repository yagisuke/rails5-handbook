class User < ApplicationRecord
  validates :email, confirmation: { on: :create }
  validates :agreement,
    acceptance: { on: :create }

  has_one :author
  has_many :reviews
  has_many :books, through: :reviews
end
