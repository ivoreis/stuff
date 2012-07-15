class CreateTimelines < ActiveRecord::Migration
  def up
    create_table :timelines, :force => true do |t|
      t.belongs_to :owner, :polymorphic => true
      t.timestamps
    end
    add_index :timelines, [:owner_id, :owner_type], :unique => true
  end

  def down
    drop_table :timelines
    remove_index :timelines, [:owner_id, :owner_type]
  end
end
