class CreateViews < ActiveRecord::Migration
  def up
    create_table :views, :force => true do |t|
      t.belongs_to :viewer, :polymorphic => true, :null => false
      t.belongs_to :viewable, :polymorphic => true, :null => false
      t.integer :times_viewed, :default => 1
      t.datetime :past_time_viewed, :default => Time.now
      t.timestamps
    end

    add_index :views, [:viewer_id, :viewer_type]
    add_index :views, [:viewable_id, :viewable_type]
    add_index :views, [:viewer_id, :viewer_type,:viewable_id, :viewable_type], :unique => true, :name => :unique_index_view
  end

  def down
    drop_table :views
    remove_index :views, [:viewer_id, :viewer_type]
    remove_index :views, [:viewable_id, :viewable_type]
    remove_index :views, [:viewer_id, :viewer_type,:viewable_id, :viewable_type], :unique => true

  end

end