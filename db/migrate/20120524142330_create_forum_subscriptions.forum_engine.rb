# This migration comes from forum_engine (originally 20120417211449)
class CreateForumSubscriptions < ActiveRecord::Migration
  def up
    create_table :forum_subscriptions, :force => true do |t|
      t.belongs_to :subscriber, :null => false
      t.belongs_to :topic, :null => false
      t.timestamps
    end
    add_index :forum_subscriptions, [:subscriber_id, :topic_id], :unique => true
  end

  def down
    drop_table   :forum_subscriptions
    remove_index :forum_subscriptions, [:subscriber_id, :topic_id]
  end

end
