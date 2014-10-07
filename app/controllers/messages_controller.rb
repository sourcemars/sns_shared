#encoding: utf-8

class MessagesController < ApplicationController
  before_filter :auth_token
  
  def create
    @fromUser = get_user_by_token(params[:token])
    @msg = Message.new
    @msg.from_user = @from_user
    @toUser = User.find_by_id(params[:message][:to_id])
    if(@toUser)
      content = params[:message][:content]
      @msg.content = content
      @msg.to_user = @toUser
      @msg.from_user = @fromUser
      
      respond_to do |format|
        if(@msg.save)
          format.json {render :text=>"{code:success,message:发送消息成功,id:#{@msg.id}}"}
        else
          format.json {render :text=>"{code:fail,message:发送消息失败"}
        end
      end
    else
      #TODO 需要返回一个错误信息
    end
  end
  
  #完成消息查询的工作
  def index
    cmd = params[:cmd]
    if(cmd)
      if(cmd == "from")
        @msgs = Message.where(:from_id => params[:message][:from_id])
        respond_to do |format|
          format.json {render :json =>@msgs}
        end
      elsif(cmd == "to_somebody")
        curUser = get_user_by_token(params[:token])
        to_id = params[:message][:to_id]
        @msgs = Message.where(:from_id => curUser.id,:to_id => to_id)
        respond_to do |format|
          format.json {render :json => @msgs}
        end
      end
    end
  end
end
