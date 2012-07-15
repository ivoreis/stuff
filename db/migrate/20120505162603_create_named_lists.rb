class CreateNamedLists < ActiveRecord::Migration
  def up
    create_table :named_lists, :force => true do |t|
      t.belongs_to :owner, :null => false
      t.string :name, :null => false
      t.timestamps
    end

    add_index :named_lists, :owner_id
    add_index :named_lists, [:owner_id, :name], :unique => true
  end

  def down
    drop_table :named_lists
    remove_index :named_lists, :owner_id
    remove_index :named_lists, [:owner_id, :name]
  end
end
