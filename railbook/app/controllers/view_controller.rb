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

  def col_select2
    @book = Book.new
    @books = Book.select(:publish).distinct
  end

  def group_select
    @review = Review.new
    @authors = Author.all
  end

  def group_select2
    @review = Review.new
    @authors = Author.all
  end

  def dat_select
    @book = Book.find(1)
  end

  def col_radio
    @book = Book.new(publish: '日経BP社')
    @books = Book.select(:publish).distinct
  end

  def fields
    @user = User.find(1)
  end

  def conc
    @books = Book.all
  end

  def partial_basic
    @book = Book.find(1)
  end

  def partial_param
    @book = Book.find(1)
  end

  def nest
    @msg = '今日もいい天気です。'
    render layout: 'child'
  end

  def adopt
    @books = Book.all
    render layout: 'view_sub'
  end

  def provide
    @books = Book.all
    @title = '@title: provide画面 | Rails入門'
  end

  def multi
    render layout: 'layout'
  end

  def relation
    render plain: 'relation'
  end

  def download
    render plain: 'download'
  end

  def quest
    render plain: 'quest'
  end

  def new
    render plain: 'new page.'
  end
end
