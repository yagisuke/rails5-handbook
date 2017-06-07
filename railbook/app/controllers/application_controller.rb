class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # RecordNotFound例外を処理するのはid_validメソッド
  rescue_from ActiveRecord::RecordNotFound, with: :id_invalid
  # 認証機能
  before_action :check_logined
  # デバイス判定
  before_action :detect_device
  # 共通flash key
  add_flash_types :info

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

  private
    def id_invalid(e)
      # ステータス404（Not Found）で指定ビューを描画
      render 'shared/record_not_found', status: 404
    end

    def detect_device
      case params[:type]
      when 'mobile'
        request.variant = :mobile
      when 'tablet'
        request.variant = :tablet
      end
    end
end
