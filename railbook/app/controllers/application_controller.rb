class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_logined

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
end
