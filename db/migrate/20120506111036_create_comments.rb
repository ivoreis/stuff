class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :force => true do |t|
      t.belongs_to :commentable, :polymorphic => true, :null => false
      t.belongs_to :commenter, :polymorphic => true, :null => false
      t.string :title, :default => ""
      t.text :body, :default => ""
      t.string :subject, :default => ""
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.timestamps
    end
    add_index :comments, :commenter_id
    add_index :comments, :commentable_id

    create_table :comment_versions, :force => true do |t|
      t.string   :item_type, :null => false
      t.integer  :item_id,   :null => false
      t.string   :event,     :null => false
      t.string   :whodunnit
      t.text     :object
      t.datetime :created_at
    end
    add_index :comment_versions, [:item_type, :item_id]
  end
  
  def self.down
    drop_table :comments
    remove_index :comments, :commenter_id
    remove_index :comments, :commentable_id
    remove_index :comment_versions, [:item_type, :item_id]
  end
end
