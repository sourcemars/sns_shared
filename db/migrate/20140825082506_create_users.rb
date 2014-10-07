class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.string :phone
      t.string :teacher 
      t.decimal :longitude,:percision => 15,:scale => 10
      t.decimal :latitude,:percision => 15,:scale => 10
      t.timestamps
    end
  end
end
