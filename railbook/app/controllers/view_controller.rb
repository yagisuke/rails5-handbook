class ViewController < ApplicationController
  def form_tag
    @book = Book.new
  end

  def form_for
    @book = Book.new
  end

  def field
    @book = Book.find(1)
  end

  def html5
    @book = Book.new
  end

  def select
    @book = Book.new
  end

  def col_select
    @book = Book.new(publish: '日経BP社')
    @books = Book.select(:publish).distinct
  end

  def group_select
    @review = Review.new
    @authors = Author.all
  end
end
