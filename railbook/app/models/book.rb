class Book < ApplicationRecord
  validates :isbn,
    presence: true,
    uniqueness: { allow_blank: true, message: 'は一意でなければなりません' },
    length: { is: 17, allow_blank: true, message: 'は%{count}桁でなければなりません' },
    isbn: { allow_old: true, allow_blank: true }
  validates :title,
    presence: true,
    length: { minimum: 1, maximum: 100, allow_blank: true }
  validates :price,
    numericality: { only_integer: true, less_than: 10000 }
  validates :publish,
    inclusion: { in: ['技術評論社', '秀和システム', '日経BP社', '翔泳社', 'ソシム']}
  validates :title, uniqueness: { scope: :publish }

  scope :gihyo, -> { where(publish: '技術評論社') }
  scope :newer, -> { order(published: :desc) }
  scope :top10, -> { newer.limit(10) }
  scope :whats_new, ->(pub) {
    where(publish: pub).order(published: :desc).limit(5)
  }

  has_many :reviews
  has_many :users, through: :reviews
  has_and_belongs_to_many :authors
  has_many :memos, as: :memoable

  after_destroy BookCallbacks.new
end
