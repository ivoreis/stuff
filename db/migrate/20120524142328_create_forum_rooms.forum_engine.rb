# This migration comes from forum_engine (originally 20120417135458)
class CreateForumRooms < ActiveRecord::Migration
  def up
    create_table :forum_rooms, :force => true do |t|
      t.string :title, :null => false
      t.string :description, :null => false
      t.boolean :public, :default => true
      t.boolean :institutional, :default => false
      t.string :slug, :null => false
      t.timestamps
    end
    add_index :forum_rooms, :slug, :unique => true
  end

  def down
    drop_table :forum_rooms
    remove_index :forum_rooms, :slug
  end
end
