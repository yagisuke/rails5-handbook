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
end
