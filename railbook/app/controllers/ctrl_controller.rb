class CtrlController < ApplicationController
  
  def para
    render plain: 'idパラメータ: ' + params[:id]
  end
end
