class SharedFile < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :tag_shared_fileships
  has_many :tags, :through => :tag_shared_fileships 
  
  # belongs_to :user :class_name => "User",:foreign_key => "user_id"
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
end
