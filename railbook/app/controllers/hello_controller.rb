class HelloController < ApplicationController
  include FormAuth
  around_action :around_logger
  skip_before_action :check_logined, only: :list

  def index
    sleep 1
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
    render 'hello/list'
  end

  def app_var
    render plain: MY_APP['logo']['source']
  end

  private
    def around_logger
      logger.debug('[START] ' + Time.now.to_s)
      yield
      logger.debug('[ END ] ' + Time.now.to_s)
    end
end
