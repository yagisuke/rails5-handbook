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
end
