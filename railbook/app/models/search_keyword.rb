class SearchKeyword
  include ActiveModel::Model

  attr_accessor :keyword

  validates :keyword,
    presence: { message: '文字列を入力してください。' }
end
