class HelloController < ApplicationController
  def index
    render plain: 'hello world.'
  end

  def view
    @title = 'hello Ruby on Rails 5.'
    @price = 3600
    @tax = 1.08
    render 'hello/view'
  end

  def list
    @books = Book.all
  end
end
