class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound , 
              with: :record_not_found

  before_action :check_login
  
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
    session[:ccc9527]
  end
end