class LoginController < ApplicationController
  include FormAuth
  skip_before_action :check_logined

  # [ログイン]ボタンのクリック時に実行されるアクション
  def auth
    # 入力値にしたがってユーザ情報を取得
    usr = User.find_by(username: params[:username])
    # ユーザ情報が存在し認証にに成功したら
    if usr && usr.authenticate(params[:password]) then
      # 成功した場合はid値をセッションに設定し、元々の要求ページにリダイレクト
      reset_session
      session[:usr] = usr.id
      redirect_to params[:referer]
    else
      # 失敗した場合はfalse[:referer]を再セットし、ログインページを再描画
      flash.now[:referer] = params[:referer]
      @error = 'ユーザ/パスワードが間違っています'
      render 'index'
    end
  end

  def logout
    reset_session
    redirect_to '/'
  end
end
