#ecoding: utf-8
require 'spec_helper'

describe UserTag do
  before do
    @user1 = User.create(:username => 'zhangsan')
    @user2 = User.create(:username => 'lisi')
    
    @tag1 = Tag.create(:name => 'Android')
    @tag2 = Tag.create(:name => 'IOS')

    @ut1 = UserTag.create(:user => @user1,:tag => @tag1)
  end
  
  context "当UserTag对象被初始化之后,关联一个User对象和一个Tag对象" do
    it "创建一个UserTag对象，保存之后就关联了user和tag对象，user当中的tag属性的值应该是保存的tag对象" do
      @user1.should == @tag1.users[0]
    end
    
    it "创建一个UserTag对象，保存之后就关联了user和tag对象，tag当中的user属性的值应该是保存的user对象" do
      @tag1.should == @user1.tags[0]
    end

    it "再创建将一个UserTag对象，在关联一个user1和tag2，这个user1的tags属性的长度应该为2，tag1和tag2的users属性的长度应该为1" do
      @ut2 = UserTag.create(:user => @user1, :tag => @tag2)
      @user1.tags.size.should == 2
      @tag1.users.size.should == 1
      @tag2.users.size.should == 1
    end
    
    it "删除一个ut1对象，user1对应的tags的长度应该为0，tag1对应的users的长度应该为0" do
      @ut1.destroy
      
      @user1.tags.size.should == 0
      @tag1.users.size.should == 0
    end
    
    
  end

end
