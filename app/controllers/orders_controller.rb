class OrdersController < ApplicationController
  def create
      # @order = Order.new(order_params)
      # @order.user = currenr_user 
      @order = current_user.orders.build(order_params) #用使用者的角度建立訂單

      current_cart.items.each do |cart_item|
        item = OrderItem.new(item: cart_item.item , 
                              price: cart_item.price , 
                              quantity: cart_item.quantity)
        @order.order_items << item
      end

      debugger #運算中斷點

      if @order.save 
        #刷卡(先建立訂單再刷卡,避免網路斷掉交易失敗，而找不到訂單)
        result = gateway.transaction.sale(
        :amount => current_cart.total,
        :payment_method_nonce => params[:order][:nonce]
        )

      if result.success?
        #成功
        @order.pay!  #aasm已經把邏輯寫在model裡
        session [:carty] = nil
        redirect_to root_path, notice: '交易成功'
      else 
        #失敗
        redirect_to root_path, alert: '交易失敗'
      end


        #清空購物車

        redirect_to root_path , notice: 'ok'

      else

        redirect_to root_path , notice: 'gg'

      end

      render html: params 
  end

  



private 

  def order_params 
    params.require(:order).permit(:receiver, :phone, :address)
  end 

end
