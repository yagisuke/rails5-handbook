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

  def updb
    @author = Author.find(params[:id])
  end

  def updb_process
    @author = Author.find(params[:id])

    if @author.update(params.require(:author).permit(:data))
      render plain: '保存に成功しました'
    else
      render plain: @author.errors.full_messages[0]
    end
  end

  def get_html
    render html: '
      <p style="color: red;">HELLO WORLD.</p>
      <script>console.log("hello world");</script>
    '.html_safe
  end

  def not_found
    render plain: 'お探しのページは見つかりませんでした。', status: 404
  end

  def redirect
    redirect_to 'http://www.wings.msn.to/'
  end

  def redirect_controller
    redirect_to controller: :hello, action: :list
  end

  def redirect_action
    redirect_to action: :req_head
  end

  def send_file_img
    send_file 'public/docs/yagi_suke.jpg', type: 'image/jpeg', disposition: :attachment
  end

  def show_photo
    id = params[:id] ? params[:id] : 1
    @author = Author.find(id)
    send_data @author.photo, type: @author.ctype, disposition: :inline
  end

  def log
    logger.unknown('unknown')
    logger.fatal('fatal')
    logger.error('error')
    logger.warn('warn')
    logger.info('info')
    logger.debug('debug')
    render plain: 'ログはコンソールまたはログファイルから確認してください'
  end

  def get_json
    @review = Review.find(1)
    render json: @review
  end
end
