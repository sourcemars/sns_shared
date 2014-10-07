#encoding: utf-8

class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  #post /users
  def create
    @user = User.new(params[:user])  
    @theSameUser = User.find_by_username(params[:user][:username])
    respond_to do |format|
      #format.html 
      if !@theSameUser && @user.save
        #format.json {render json:@user,status: :created,location:@user}
        format.json {render :text => "{code:success,message:注册成功}"}
      elsif
        format.json {render :text => "{code:fail,message:注册失败}"}
      end
    end
  end 
  
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.json {render json:@user}
    end 
  end
  
  #GET /users?page=n
  def index
    page = params[:page].to_i
    @users = User.get_users_by_page(page)
    
    respond_to do |format|
      format.json {render json:@users}
    end
  end
  
  #PUT /users
  #http://localhost:3000/users/:id
  def update
    @cmd = params[:cmd] 
    @curUser = User.find_by_id(params[:id])
    if @cmd == 'add_friend'
      friendIds = params[:friends]
      idArr = friendIds.split(',')
      idArr.each do |idStr|
        friend = User.find_by_id(idStr)
        if(friend)
          @curUser.friends << friend
        end
      end
      respond_to do |format|
        format.json {render :text => "{code:success,message=添加好友成功}"}
      end
      puts '添加好友'
    elsif @cmd == 'delete_friend' 
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
      puts '删除好友'
    elsif @cmd == 'list_friend'
      respond_to do |format|
        format.json {render :json => @curUser.friends}
      end
      puts '查询文件列表'
    end
    
  end
  
end
