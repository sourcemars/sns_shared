#encoding: utf-8
class SharedFilesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :auth_token
  
  #完成下载文件的功能
  def show
    #文件类型，如果该值为空的话，就需要返回所有的类型
    type = params[:sharedfiles][:type]
    #查询的文件tag，可能会有多个
    tags = params[:sharedfiles][:tags]
    puts("tags",tags)
    tagArr = tags.split(",")
    #查询的页
    pageStr = params[:sharedfiles][:page]
    #数据的条数
    count = params[:sharedfiles][:count]
    
    @conditions = {}
    @conditions.merge!({:type => type}) if type
    
    @conditions.merge!({:tag => tags}) if tags
    puts("-----------",@conditions)
    
    @files = SharedFile.find(:all,:conditions => @conditions)
    
    # render :text => "text to render..."
    
    #创建查询条件数组对象
    
    
    
  end
  
  # /POST
  def create
    @file = params[:sharedfile][:file]
    @username = params[:sharedfile][:username]
    @summary = params[:sharedfile][:summary]
    @name = params[:sharedfile][:name]
    @tags = params[:sharedfile][:tag]
    @type = params[:sharedfile][:type]
    @token = params[:sharedfile][:token]
    curUser = get_user_by_token(@token)
    #创建一个新的SharedFile对象
    @sharedFile = SharedFile.new(:summary => @summary,:name => @file.original_filename)
    #根据用户提交的token，找出对应的User对象
    #curUser = User.get_user_by_token(@token)
    @sharedFile.user = curUser
    tagArr = @tags.split(",")
    #遍历整个数组，判断标签是否已经存在
    tagArr.each do |tagStr|
      #tagObj = Tag.where(:name => tagStr).first
      tagObj = Tag.find_by_name(tagStr)
      #如果当前的标签不存在，就创建一个新的标签
      if(!tagObj)
        tagObj = Tag.create(:name => tagStr)
        tagObj.save
      end
      #将标签数据放置在共享文件当中
      @sharedFile.tags << tagObj
    end
    
    uuidName = uploadFile(@file,curUser.username)
    #TODO如果没有保存成功，需要将已经上传的文件删除
    @sharedFile.uuid = uuidName
    #保存共享文件对象
    respond_to do |format|
      if(@sharedFile.save)
        format.json {render :text => "{code:success,message:上传成功,id:#{@sharedFile.id}}"}
      elsif
        format.json {render :text => "{code:fail,message:上传失败}"}
      end
    end
  end
  
  def uploadFile(file,username)
    #获取上传文件的原始名称
    @origName = file.original_filename
    #生成一个UUID作为文件名
    @uuidFileName = SecureRandom.uuid
    fileDir = "#{Rails.root}/public/upload/#{username}"
    puts("fileDIr",fileDir)
    #判断文件夹是否存在，如果不存在就创建
    if(!File.exist?(fileDir))
      Dir.mkdir(fileDir)
    end
    #生成文件的路径
    filePath = "#{fileDir}/#{@uuidFileName}"
    puts("保存文件的路径为:",filePath)
    File.open(filePath,"wb") do |f|
      f.write(file.read)
    end
    @uuidFileName
  end
end
