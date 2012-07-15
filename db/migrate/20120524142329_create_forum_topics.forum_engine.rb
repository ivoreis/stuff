# This migration comes from forum_engine (originally 20120417135543)
class CreateForumTopics < ActiveRecord::Migration
  def up
    create_table :forum_topics, :force => true do |t|
      t.string :title, :null => false
      t.belongs_to :owner, :null => false
      t.belongs_to :room, :null => false
      t.text :content, :null => false
      t.boolean :pinned, :default => false
      t.string :slug, :null => false
      t.timestamps
    end
    add_index :forum_topics, :slug, :unique => true
  end

  def down
    drop_table :forum_topics
    remove_index :forum_topics, :slug
  end
end
