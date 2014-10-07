#ecoding: utf-8
require 'spec_helper'


describe Tag do
  before do
    @tag = Tag.new
  end
  
  context "当Tag对象初始化时" do
    it "name属性的值应该为空" do
      @tag.name.should == nil
    end
  end
  
  context "当Tag被保存之后" do
    it "name 的值应该是" do
      @tag = Tag.create(:name => 'android')

      @findTag = Tag.find(@tag.id)
      
      @findTag.name.should == 'android'
    end 
  end
end
