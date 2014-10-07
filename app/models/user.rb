class User < ActiveRecord::Base
  # attr_accessible :title, :body
  # attr_accessible :username, :password
  #用户与标签之间的关系
  has_many :user_tags
  has_many :tags, :through => :user_tags
  #用户与好友之间的关系
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  #用户与token之间的关系
  has_one :token
  
  #用户与消息之间的关系
  has_many :from_messages, :class_name => "Message", :foreign_key => "from_id"
  has_many :to_messages, :class_name => "Message", :foreign_key => "to_id"  
  
  
  $PAGE_SIZE = 5
  
  def User.get_users_by_page(page)
    count = User.all.count
    page_count = (count + $PAGE_SIZE - 1) / $PAGE_SIZE
    
    if page < 0 
      page = 1
    elsif page > page_count
      page = page_count
    end
    
    limit = $PAGE_SIZE * page
    offset = (page - 1) * $PAGE_SIZE 
    puts($PAGE_SIZE,count,page_count,limit,offset)
    
    users = User.limit(limit).offset(offset)
  end
  
  def User.get_user_by_token(token)
    user = User.where(:username => token).first
  end
end