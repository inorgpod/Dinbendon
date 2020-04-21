class CartsController < ApplicationController
  def destory
    session[:carty] = nil
    redirect_to root_path, notice: '購物車已清除'
end
