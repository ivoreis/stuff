# This migration comes from forum_engine (originally 20120418100742)
class CreateForumModerations < ActiveRecord::Migration
  def up
    create_table :forum_moderations, :force => true do |t|
      t.belongs_to :room, :null => false
      t.belongs_to :moderator, :null => false
      t.timestamps
    end
    add_index :forum_moderations, [:room_id, :moderator_id], :unique => true
  end

  def down
    drop_table :forum_moderations
    remove_index :forum_moderations, [:room_id, :moderator_id]
  end
end
