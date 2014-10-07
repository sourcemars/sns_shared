class AddUuidToSharedFiles < ActiveRecord::Migration
  def change
    add_column :shared_files, :uuid, :string
  end
end