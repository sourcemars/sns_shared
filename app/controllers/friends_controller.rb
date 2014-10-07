#encoding: utf-8
#该controller主要用于完成对用户好友的操作,所有的操作都必须通过auth_token过滤器
class FriendsController < ApplicationController
  
  before_filter :auth_token
  #为一个用户添加一个好友
  def create
    @curUser = get_user_by_token(params[:token])
    friendIds = params[:friends]
    idArr = friendIds.split(',')
    idArr.each do |idStr|
      friend = User.find_by_id(idStr)
      if(friend  && !@curUser.friends.include?(friend))
        @curUser.friends << friend
      end
    end
    respond_to do |format|
      format.json {render :text => "{code:success,message=添加好友成功}"}
    end
    puts '添加好友'
  end
  
  #删除一个用户的还有
  def destroy
    @curUser = get_user_by_token(params[:token])
    friendIds = params[:friends]
    idArr = friendIds.split(',')
    idArr.each do |idStr|
    friend = User.find_by_id(idStr)
    if(friend)
      @curUser.friends.delete(friend)
      end
    end
    respond_to do |format|
      format.json {render :text => "{code:success,message=删除好友成功}"}
    end
  end
  
  #获取用户的好友列表
  #TODO 需要完成好友的分页显示
  def index
    @curUser = get_user_by_token(params[:token])
    respond_to do |format|
      format.json {render :json => @curUser.friends}
    end
  end
  
  
end
