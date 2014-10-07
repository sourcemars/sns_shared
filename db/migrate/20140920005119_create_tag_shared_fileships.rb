class CreateTagSharedFileships < ActiveRecord::Migration
  def change
    create_table :tag_shared_fileships do |t|
      t.integer :tag_id
      t.integer :shared_file_id

      t.timestamps
    end
  end
end
