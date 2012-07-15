class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.belongs_to :owner, :polymorphic => true
      t.belongs_to :creator, :polymorphic => true
      t.string :title
      t.text :details
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :all_day
      t.boolean :repeat
      t.timestamps
    end
    add_index :events, [:owner_id, :owner_type]
    add_index :events, [:creator_id, :creator_type]
  end

  def down
    drop_table :events
    remove_index :events, [:owner_id, :owner_type]
    remove_index :events, [:creator_id, :creator_type]
  end
end
