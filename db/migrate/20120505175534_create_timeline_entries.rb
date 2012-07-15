class CreateTimelineEntries < ActiveRecord::Migration
  def up
    create_table :timeline_entries, :force => true do |t|
      t.belongs_to :timeline, :null => false
      t.belongs_to :visibility, :null => false
      t.belongs_to :owner, :polymorphic => true, :null => false
      t.string :content_type, :null => false
      t.text :content, :null => false
      t.boolean :system, :default => false
      t.timestamps
    end
    add_index :timeline_entries, [:timeline_id, :visibility_id]
    add_index :timeline_entries, [:owner_id, :owner_type]
  end

  def down
    drop_table :timeline_entries
    remove_index :timeline_entries, [:timeline_id, :visibility_id]
    remove_index :timeline_entries, [:owner_id, :owner_type]
  end
end
