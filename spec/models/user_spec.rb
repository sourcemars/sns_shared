#encoding: utf-8
require "spec_helper"

describe User do
  before do
    @user = User.new
  end
  
  context "when initialized" do
    it "should have default username is nil" do
       @user.username.should == nil
    end
    
    it "should havedefault password is nil" do
      @user.password.should == nil
    end
  end
  
  context "创建新的用户，然后将数据保存在数据库当中" do
    it "从数据库当中将新用户查询出来，用户名应该是zhangsan，密码是123456" do
      @user = User.new(:username => "zhangsan",:password=>"123456")
      @user.save
      @findUser = User.find(@user.id)
      @findUser.username.should == "zhangsan" && @findUser.password.should == "123456"
    end
  end
end