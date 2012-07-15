class CreateNamedListEntries < ActiveRecord::Migration
  def up
    create_table :named_list_entries, :force => true do |t|
      t.belongs_to :named_list, :null => false
      t.belongs_to :person, :null => false
      t.timestamps
    end
    add_index :named_list_entries, [:named_list_id, :person_id], :unique => true
  end

  def down
    drop_table :named_list_entries
    remove_index :named_list_entries, [:named_list_id, :person_id]
  end
end
