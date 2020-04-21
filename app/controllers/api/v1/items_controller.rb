class Api::V1::ItemsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  # skip_before_action :check_login
  def favorite 
    item = Item.find(paramsp[:id])
    #item = current_user.items.find_by(params[:id])#user有很多的items 用find_by是因我的最愛功能是boolean值
    
    if item.favorited_by(current_user)
    #移除最愛
    #FavoriteItem.find_by(item: item).destroy

    current_user.items.delete(item: item)
    render json: {status: 'removed'}
    else
    
    #加到最愛

    current_user.items << item
    render json: {status: 'favorited'}
    end
  end
end
