class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # RecordNotFound例外を処理するのはid_validメソッド
  rescue_from ActiveRecord::RecordNotFound, with: :id_invalid
  # デバイス判定
  before_action :detect_device
  # 共通flash key
  add_flash_types :info

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
