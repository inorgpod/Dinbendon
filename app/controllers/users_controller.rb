class UsersController < ApplicationController
  skip_before_action :check_login , except: [:logout]

  def login
  @user = User.new
  end

  def sign_up
    # render html: "login 測試"
    @user = User.new
  end

  def logout
    session[:ccc9527] = nil
    redirect_to root_path
  end

  def sign_in
      user = User.find_by(email: user_params[:email] , 
                          password: user_params[:password])
      if user 
      session[:ccc9527] = user.id
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

  

  def registration
    # if user_params[:password] == user_params[:password_confirm]
      #新增使用者
      #strong parameters
      # 因為沒有password_confirm的值所以需要建立一個或者在user.rb新增 attr_accessor :password_confirm來騙modal
    @user = User.new(user_params)

    if @user.save
      #成功
        # TODO: 密碼加密
      session[:ccc9527] = @user.email
      redirect_to root_path
    else
      #失敗
      #redirect_to "/sign_up"         
      render  :sign_up
      #render > erb的概念
    end
  end
  
    # redirect_to "/login"
    # else
    # redirect_to "/sign_up"
    # end
    def logout
      session[:ccc9527] = nil
      redirect_to root_path
    end
  end



  private 
    def user_params 
      params.require(:user).permit(:email,:password,:password_confirmation)
    end


