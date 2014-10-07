class TagSharedFileship < ActiveRecord::Base
  attr_accessible :shared_file_id, :tag_id
  
  belongs_to :tag
  belongs_to :shared_file
end
