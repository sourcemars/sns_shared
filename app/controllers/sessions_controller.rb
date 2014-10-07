#encoding: utf-8
#该类的主要功能是控制用户的登录信息以及相关的状态
class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  #before_filter :auth_token
  
  #主要用于完成用户的登录功能 使用post提交，提交的内容包括name和pwd
  def create
    name = params[:session][:username]
    password = params[:session][:password]
    
    @user = User.where(:username => name,:password => password).first
    if(@user)
      puts("------","success")
      #首先判断当前用户是否已经生成了TOKEN
      flag = false
      if(@user.token)
        #如果用户已经拥有了Token，则需要判断这个Token是否过期
        if(@user.token.isExpired)
          flag = true
          @user.token.delete
        end
      else
        flag = true
      end
      puts("flag:",flag)
      if(flag)
        #用户登录成功，需要生成用户的token，然后将token返回给用户
        userToken = Token.new
        tokenUUID = SecureRandom.uuid
        userToken.value = tokenUUID
        userToken.save
        @user.token = userToken
      end
      
      respond_to do |format|
        format.json { render :json => @user.to_json(:include => :token) }
      end
    elsif
      #用户登录失败，返回失败信息
      respond_to do |format|
        format.json {render :text => "{code:fail,message:登录失败}"}
      end
      puts("------","failed")
    end
  end

end
