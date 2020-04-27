class CartsController < ApplicationController
  def destory
    session[:carty] = nil
    redirect_to root_path, notice: '購物車已清除'
  end
  
  def checkout
    @order = Order.new

    gateway = Braintree::Gateway.new(
  :environment => :sandbox,
  :merchant_id => 's5c9tw2266y9sb7d',
  :public_key => 'drdfm85zr8q8n97r',
  :private_key => '25213300af9c756d81549788be386bbd',
) 
    @token = gateway.client_token.generate
  end
end
