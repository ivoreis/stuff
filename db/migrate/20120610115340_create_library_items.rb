class CreateLibraryItems < ActiveRecord::Migration
  def up
    create_table :library_items do |t|
      t.string :description, :null => false
      t.string :author, :null => false
      t.string :title, :null => false
      t.belongs_to :owner, :polymorphic => true, :null => false
      t.timestamps
    end
    add_index :library_items, [:owner_id, :owner_type]
  end

  def down
    drop_table :library_items
    remove_index :library_items, [:owner_id, :owner_type]
  end
end
