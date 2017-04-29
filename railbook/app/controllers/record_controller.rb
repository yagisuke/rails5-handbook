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

  def where2
    @books = Book.all
    @books.where!(publish: '技術評論社')
    @books.order!(published: :desc)
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

  def select2
    @pubs = Book.select(:publish).distinct.order(publish: :desc)
  end

  def offset
    @books = Book.order(published: :desc).limit(3).offset(4)
    render 'hello/list'
  end

  def page
    page_size = 3
    page_num = params[:id] == nil ? 0 : params[:id].to_i - 1
    @books = Book.order(published: :desc).limit(page_size).offset(page_num)
    render 'hello/list'
  end

  def last
    @book = Book.order(published: :desc).last
    render 'books/show'
  end

  def groupby
    @books = Book.select('publish, AVG(price) AS avg_price')
      .group(:publish)
    render 'record/groupby'
  end

  def havingby
    @books = Book.select('publish, AVG(price) AS avg_price')
      .group(:publish)
      .having('AVG(price) >= ?', 2500)
    render 'record/groupby'
  end

  def unscope
    @books = Book.where(publish: '技術評論社').order(:price)
      .select(:isbn, :title).unscope(:where, :select)
    render 'books/index'
  end


  def none
    case params[:id]
      when 'all'
        @books = Book.all
      when 'new'
        @books = Book.order('published DESC').limit(5)
      when 'cheap'
        @books = Book.order(:price).limit(5)
      else
        @books = Book.none
    end
    render 'books/index'
  end

  def pluck
    render plain: Book.where(publish: '技術評論社').pluck(:title, :price)
  end

  def exists
    flag = Book.where(publish: 'hoge出版社').exists?
    render plain: "存在するか？ : #{flag}"
  end

  def scope
    @books = Book.gihyo.top10
    render 'hello/list'
  end

  def publish_rank
    @books = Book.whats_new('技術評論社')
    render 'hello/list'
  end
end
