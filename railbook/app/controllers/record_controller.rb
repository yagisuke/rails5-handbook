class RecordController < ApplicationController
  def find
    @books = Book.find([2, 5, 10])
    render 'hello/list'
  end

  def find_by
    @book = Book.find_by(publish: '技術評論社')
    render 'books/show'
  end

  def find_by2
    @book = Book.find_by(publish: '技術評論社', price: 2980)
    render 'books/show'
  end

  def where
    @books = Book.where(publish: '技術評論社')
    render 'hello/list'
  end

  def ph1
    @books = Book.where('publish = ? AND price >= ?', params[:publish], params[:price])
    render 'hello/list'
  end

  def not
    @books = Book.where.not(isbn: params[:id])
    render 'books/index'
  end

  def where_or
    @books = Book.where(publish: '技術評論社').or(Book.where('price > 3500'))
    render 'hello/list'
  end

  def order
    @books = Book.where(publish: '技術評論社').order(published: :desc)
    render 'hello/list'
  end

  def reorder
    @books = Book.where(publish: '技術評論社').order(published: :desc).reorder(published: :asc)
    render 'hello/list'
  end

  def select
    @books = Book.where('price > 2000').select(:isbn, :title, :price, :publish, :published, :dl)
    render 'hello/list'
  end
end
