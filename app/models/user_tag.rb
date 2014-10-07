class UserTag < ActiveRecord::Base
  attr_accessible :tag_id, :user_id,:user,:tag
  
  belongs_to :user
  belongs_to :tag
end
