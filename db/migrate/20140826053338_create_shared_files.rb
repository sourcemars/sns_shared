class CreateSharedFiles < ActiveRecord::Migration
  def change
    create_table :shared_files do |t|
      t.string :name
      t.string :summary
      t.integer :size
      t.string :type
      t.timestamps
    end
  end
end
