class CreateTaggables < ActiveRecord::Migration
  def self.up
    create_table :tags, :force => true do |t|
      t.string :name, :null => false
    end

    create_table :taggings, :force => true do |t|
      t.belongs_to :tag, :null => false
      t.belongs_to :taggable, :polymorphic => true, :null => false
      t.belongs_to :tagger, :polymorphic => true, :null => false
      t.string :context, :limit => 128
      t.timestamps
    end

    add_index :taggings, :tag_id
    add_index :taggings, [:tagger_id, :tagger_type]
    add_index :taggings, [:taggable_id, :taggable_type, :context]
  end

  def self.down
    drop_table :taggings
    drop_table :tags
    remove_index :taggings, :tag_id
    remove_index :taggings, [:tagger_id, :tagger_type]
    remove_index :taggings, [:taggable_id, :taggable_type, :context]
  end
end
