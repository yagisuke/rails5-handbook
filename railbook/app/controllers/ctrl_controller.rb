class CtrlController < ApplicationController

  def para
    render plain: 'idパラメータ: ' + params[:id]
  end

  def para_array
    render plain: 'categoryパラメータ: ' + params[:category].inspect
  end

  def req_head
    @headers = request.headers
    render 'ctrl/req_head'
  end

  def req_head_ua
    render plain: request.headers['User-Agent']
  end

  def upload_process
    # アップロードファイルを取得
    file = params[:upfile]
    # ファイルのベース名(パスを除いた部分)
    img_name = file.original_filename
    # 許可する拡張子を定義
    perms = ['.jpg', '.jpeg', '.gif', '.png']
    # 配列permsにアップロードファイルの拡張子に合致するものがあるか
    if !perms.include?(File.extname(img_name).downcase)
      result = 'アップロードできるのは画像ファイルのみです'
    # アップロードファイルのサイズが1MB以下であるか
    elsif file.size > 1.megabyte
      result = 'ファイルサイズは1MBまでです。'
    else
      # /public/docフォルダ配下にアップロードファイルを保存
      File.open("public/docs/#{img_name}", 'wb') {
        |f| f.write(file.read)
      }
      result = "#{img_name}をアップロードしました。"
    end
    # 成功 / エラーメッセージを表示
    render plain: result
  end
end
