class CreateFavorites < ActiveRecord::Migration
  def up
    create_table :favorites, :force => true do |t|
      t.belongs_to :favorable, :polymorphic => true, :null => false
      t.belongs_to :favoriter, :polymorphic => true, :null => false
      t.timestamps
    end

    add_index :favorites, [:favorable_id, :favorable_type]
    add_index :favorites, [:favoriter_id, :favoriter_type]
  end

  def down
    drop_table :favorites
    remove_index :favorites, [:favorable_id, :favorable_type]
    remove_index :favorites, [:favoriter_id, :favoriter_type]
  end

end