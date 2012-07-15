# This migration comes from mailboxer_engine (originally 20110511145103)
class CreateMailboxer < ActiveRecord::Migration
  def self.up
    #Tables

    #Conversations
    create_table :conversations, :force => true do |t|
      t.belongs_to :originator, :polymorphic => true, :null => false
      t.boolean :group, :default => false
      t.timestamps
    end
    add_index :conversations, [:originator_id, :originator_type]

    #Messages
    create_table :messages, :force => true do |t|
      t.belongs_to :sender, :polymorphic => true, :null => false
      t.belongs_to :conversation, :null => false
      t.text :body, :null => false
      t.string :subject,:default => ""
      t.string :attachment, :default => ""
      t.timestamps
    end
    add_index :messages, :conversation_id
    add_index :messages, [:sender_id, :sender_type]

    create_table :recipients, :force => true do |t|
      t.belongs_to :conversation, :null => false
      t.belongs_to :receiver, :polymorphic => true, :null => false
      t.timestamps
    end
    add_index :recipients, [:conversation_id, :receiver_id, :receiver_type], :name => :index_recipients_on_conversation_receiver, :unique => true

    #Receipts
    create_table :receipts, :force => true do |t|
      t.belongs_to :recipient, :null => false
      t.belongs_to :message, :null => false
      t.boolean :read, :default => false
      t.timestamps
    end
    add_index :receipts, :recipient_id
    add_index :receipts, :message_id


    #Notifications
    create_table :notifications, :force => true do |t|
      t.belongs_to :sender, :polymorphic => true, :null => false
      t.belongs_to :notified_object, :polymorphic => true, :null => false
      t.belongs_to :destination, :polymorphic => true, :null => false
      t.boolean :read, :default => false
      t.timestamps
    end
    add_index :notifications, [:sender_id, :sender_type],:name => :index_notifications_on_sender
    add_index :notifications, [:notified_object_id, :notified_object_type] , :name => :index_notifications_on_notified_object
    add_index :notifications, [:destination_id, :destination_type], :name => :index_notifications_on_destination

    #Mentions
    create_table :mentions, :force => true do |t|
      t.belongs_to :originator, :polymorphic => true, :null => false
      t.belongs_to :mentionable, :polymorphic => true, :null => false
      t.belongs_to :mentionable_container, :polymorphic => true, :null => false
      t.timestamps
    end
    add_index :mentions, [:originator_id, :originator_type], :name => :index_mentions_on_originator
    add_index :mentions, [:mentionable_id, :mentionable_type], :name => :index_mentions_on_mentionable
    add_index :mentions, [:mentionable_container_id, :mentionable_container_type] , :name => :index_mentions_on_mentionable_container

  end

  def self.down
    drop_table :conversations
    drop_table :receipts
    drop_table :notifications
    drop_table :messages
    drop_table :mentions
    drop_table :delivery_groups
  end
end
