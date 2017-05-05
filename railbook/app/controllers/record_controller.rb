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

  def groupby2
    @books = Book.group(:publish).average(:price)
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

  def def_scope
    render plain: Review.all.inspect
  end

  def count
    cnt = Book.where(publish: '技術評論社').count
    render plain: "#{cnt}件です。"
  end

  def publish_count
    cnt = Book.distinct.count(:publish)
    render plain: "#{cnt}件です。"
  end

  def average
    price = Book.where(publish: '技術評論社').average(:price)
    render plain: "平均価格は#{price}円です。"
  end

  def literal_sql
    @books = Book.find_by_sql(['
      SELECT publish, AVG(price) AS avg_price
      FROM "books"
      GROUP BY publish
      HAVING AVG(price) >= ?', 2500])
    render 'record/groupby'
  end

  def update_all
    cnt = Book.where(publish: 'Gihyo').update_all(publish: '技術評論社')
    render plain: "#{cnt}件のデータを更新しました。"
  end

  def update_all2
    cnt = Book.order(:published).limit(5).update_all('price = price * 0.8')
    render plain: "#{cnt}件のデータを更新しました。"
  end

  def destroy
    Book.where(publish: 'hoge').destroy_all
    render plain: '削除完了'
  end

  def transact
      Book.transaction do
        b1 = Book.new({
          isbn: '978-4-7741-5067-3',
          title: 'Rubyポケットリファレンス',
          price: 2580,
          publish: '技術評論社',
          published: '2017-04-17',
          dl: 'f'})
        b1.save!

        raise '例外発生: 処理はキャンセルされました'

        b2 = Book.new({
          isbn: '978-4-7741-5067-5',
          title: 'Tomcatポケットリファレンス',
          price: 2500,
          publish: '技術評論社',
          published: '2017-05-10',
          dl: 'f'})
        b2.save!
      end
      render plain: 'トランザクションは成功しました。'
    rescue => e
      render plain: e.message
  end

  def enum_rec
    @review = Review.find(1)
    @review.published!
    render plain: 'ステータス: ' + @review.status
  end

  def get_published
    @reviews = Review.published
    render 'reviews/index'
  end

  def keywd
    @search = SearchKeyword.new
  end

  def keywd_process
    @search = SearchKeyword.new(params.require(:search_keyword).permit(:keyword))

    if @search.valid?
      render plain: @search.keyword
    else
      render plain: @search.errors.full_messages[0]
    end
  end

  def belongs
    @review = Review.find(3)
  end

  def hasmany
    @book = Book.find_by(isbn: '978-4-7980-4803-1')
  end

  def hasone
    @user = User.find(1)
  end

  def has_and_belongs
    @book = Book.find_by(isbn: '978-4-7980-4803-1')
  end

  def has_many_through
    @user = User.find_by(username: 'isatou')
  end

  def fan_comment
    @author = Author.find(1)
  end

  def cache_counter
    @user = User.find(1)
  end

  def book_memorize
    @book = Book.find(1)
    # 書籍情報に関連するメモを登録
    @memo = @book.memos.build({ body: 'あとで買う' })
    if @memo.save
      render plain: 'メモを作成しました。'
    else
      render plain: @memo.errors.full_messages[0]
    end
  end

  def author_memorize
    @author = Author.find(1)
    # 書籍情報に関連するメモを登録
    @memo = @author.memos.build({ body: 'この人イケメン' })
    if @memo.save
      render plain: 'メモを作成しました。'
    else
      render plain: @memo.errors.full_messages[0]
    end
  end

  def assoc_join
    @books = Book.joins(:reviews, :authors).
      order('books.title, reviews.updated_at').
      select('books.id, books.title, books.published, books.price, reviews.body, authors.name')
    render plain: @books.inspect
  end
end
