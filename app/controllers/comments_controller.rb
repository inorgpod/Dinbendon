class CommentsController < ApplicationController

  def create #用使用者的角度建立comment
    #@comment = Comment.new(commemt_params, item_id: params[:items_id,
                                            # user_id: current_user.id])
                                            # @comment = current_user.comment.build(comment_params)
    #@comment.item_id = params[:item_id]
    #@comment.user_id = current_user.id
    @item = Item.find(params[:item_id])
    @comment = @item.comments.build(comment_params.merge(user: current_user)) #以物品的角度去找comment
    #@comment.item = @item

    if @comment.save 
      #render json: {name: '1111', age: 18}
      #redirect_to item_path(params[:item_id]), notice:'ok' #巢狀網址的params id => :item_id
    else 
      render 'items/show'
    end
  end


  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end