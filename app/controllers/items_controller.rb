class ItemsController < ApplicationController
  
  before_action :find_item , only: [:show , :edit , :update, :destroy, :add_to_cart]
  
  
  def index 
    @items = Item.all
  end


  def show 
    @comment = Comment.new
    @comments = @item.comments.includes(:user) #使用IN的方法查資料 而不是用 n+1 Query的方法 EAGER LOADING
  end


  def new
    @item = Item.new
  end

  def create 
    @item = Item.new(item_params)
    if @item.save  #使用@實體變數因為要跨到別的view或model去使用
      redirect_to items_path, notice: '成功新增餐點！'
    else
      render :new
    end
  end

  def add_to_cart
    #cart = Cart.from_hash(session[:carty])
    #cart.add_item{@item.id}
    current_cart.add_item(@item.id)
    session[:carty] = current_cart.to_hash #session只能存字串不能存物件

    redirect_to root_path, notice: '已加到購物車'
  end
  
  
  def edit 
  end
  
  def update 
    
    if @item.update(item_params)
      redirect_to items_path, notice: '成功更新餐點！'
    else
      render :edit
    end
    
  end
  
  def destroy
    @item.destroy
    # @item.update(deleted_at: Time.now) 
    redirect_to items_path , notice: '成功刪除餐點'
  end
  


  private 
  def find_item
    #@item = Item.find(params[:id])
    @item = Item.find_by(id: params[:id], deleted_at: nil)
  end

  def item_params
    params.require(:item).permit(:name, 
                                :description,
                                :price,
                                :category_id,
                                :spec,
                                :cover)
  end
end
