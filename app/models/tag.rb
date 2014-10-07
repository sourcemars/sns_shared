class Tag < ActiveRecord::Base
  # attr_accessible :title, :body
  # attr_accessible :name
  
  has_many :user_tags
  has_many :users, :through => :user_tags

  has_many :tag_shared_fileships
  has_many :shared_files, :through => :tag_shared_fileships
end
