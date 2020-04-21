class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound , 
              with: :record_not_found

  before_action :check_login
  helper_method :current_user, :current_cart
  # helper_method :current_user
  # include UsersHelper 
              


  private 
  def check_login
    redirect_to login_path if not current_user 
  end
      
      
  def record_not_found 
    render  file: 'public/404.html' , 
            status: 404,
            layout: false
  end

  def current_user 
    #session[:ccc9527] #<- id
    User.find_by(id: session[:ccc9527]) #用user find_by尋找current user的id 就算找不到也可以有回傳值反之find沒有回傳值會到activeRecord notFound -> 404page
  end

  def current_cart
    @_ca123 ||= Cart.from_hash(session[:carty])
  end
end