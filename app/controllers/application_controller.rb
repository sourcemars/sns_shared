#encoding: utf-8
class ApplicationController < ActionController::Base
  #protect_from_forgery
  
  def auth_token
    tokenStr = params[:token]
    puts("auth_token------------------------",tokenStr)
    token = Token.find_by_value(tokenStr)
    if(token)
      #user = User.find_by_token_id(token.id)
      #user = User.find_by_sql("select * from users,tokens where tokens.user_id = users.id and tokens.value=?",tokenStr)
      if(token.isExpired)
        respond_to do |format|
          format.json {render :text => "{error:1,message:token过期}"}
        end
        return
      end
      user = User.find_by_id(token.user_id)
      puts("auth_token-------------------",user)
    else
      respond_to do |format|
        format.json {render :text => "{error:1,message:token错误}"}
      end
    end
  end
  
  def get_user_by_token(token)
    token = Token.find_by_value(token)
    if(token)
      user = User.find_by_id(token.user_id)
      return user
    end
  end
end
