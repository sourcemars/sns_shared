class AddUserIdToSharedfiles < ActiveRecord::Migration
  def change
    add_column :shared_files,:user_id,:integer
  end
end
