class HelloController < ApplicationController
  around_action :around_logger
  before_action :check_logined, only: :view

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
    def check_logined
      # セッション情報:usr (id値)が存在するか
      if session[:usr] then
        # 存在する場合はuserテーブルを検索し、ユーザ情報を取得
        begin
          @usr = User.find(session[:usr])
          # ユーザー情報が存在しない場合は不正なユーザと見なし、セッションを破棄
        rescue ActiveRecord::RecordNotFound
          reset_session
        end
      end
      # ユーザ情報を取得できなかった場合にはログインページ(login#index)へ
      unless @usr
        flash[:referer] = request.fullpath
        redirect_to controller: :login, action: :index
      end
    end

    def around_logger
      logger.debug('[START] ' + Time.now.to_s)
      yield
      logger.debug('[ END ] ' + Time.now.to_s)
    end
end
