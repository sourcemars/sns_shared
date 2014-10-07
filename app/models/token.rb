class Token < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  
  #判断一个Token是否已经过期
  def isExpired
    if((Time.now - self.created_at ) > 7 * 24 * 60 * 60)
      return true;
    end
    return false;
  end
end
