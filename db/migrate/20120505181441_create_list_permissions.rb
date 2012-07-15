class CreateListPermissions < ActiveRecord::Migration
  def up
    create_table :list_permissions, :force => true do |t|
      t.belongs_to :named_list, :null => false
      t.belongs_to :permission, :null => false
      t.timestamps
    end
    add_index :list_permissions, [:named_list_id, :permission_id], :unique => true
  end

  def down
    drop_table :list_permissions
    remove_index :list_permissions, :owner_id
  end
end
