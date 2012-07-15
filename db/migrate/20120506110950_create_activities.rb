# Migration responsible for creating a table with activities
class CreateActivities < ActiveRecord::Migration
  # Create table
  def self.up
    create_table :activities, :force => true do |t|
      t.belongs_to :traceable, :polymorphic => true, :null => false
      t.belongs_to :owner, :polymorphic => true, :null => false
      t.string  :key, :null => false
      t.text    :parameters
      t.timestamps
    end
    add_index :activities, [:traceable_id, :traceable_type]
    add_index :activities, [:owner_id, :owner_type]

  end
  # Drop table
  def self.down
    drop_table :activities
    remove_index :activities, [:traceable_id, :traceable_type]
    remove_index :activities, [:owner_id, :owner_type]
  end
end
