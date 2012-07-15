class CreateSubjectPermissions < ActiveRecord::Migration
  def up
    create_table :subject_permissions, :force => true do |t|
      t.belongs_to :permission, :null => false
      t.belongs_to :owner, :polymorphic => true, :null => false
      t.timestamps
    end
    add_index :subject_permissions, [:permission_id, :owner_id, :owner_type], :unique => true, :name => :index_subject_permissions
  end

  def down
    drop_table :subject_permissions
    remove_index :subject_permissions, [:permission_id, :owner_id, :owner_type]
  end
end
