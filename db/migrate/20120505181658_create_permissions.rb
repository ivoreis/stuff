class CreatePermissions < ActiveRecord::Migration
  def up
    create_table :permissions, :force => true do |t|
      t.belongs_to :action_permission, :null => false
      t.belongs_to :predicate_permission, :null => false
      t.string :options
    end
    add_index :permissions, [:action_permission_id, :predicate_permission_id], :unique => true, :name => :unique_index_permissions

    create_table :action_permissions, :force => true do |t|
      t.string :name, :null => false
    end

    create_table :predicate_permissions, :force => true do |t|
      t.string :name, :null => false
    end

    [:view, :create, :update, :destroy, :moderate].each do |action|
      ActionPermission.create(name: action.to_s)
    end
  end

  def down
    drop_table :permissions
    drop_table :action_permissions
    drop_table :predicate_permissions
    remove_index :permissions, [:action_permission_id, :predicate_permission_id]
  end
end
