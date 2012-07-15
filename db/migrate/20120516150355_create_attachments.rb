class CreateAttachments < ActiveRecord::Migration
  def up
    create_table :attachments, :force => true do |t|
      t.belongs_to :attached_at, :polymorphic => true
      t.string :content
      t.timestamps
    end
    add_index :attachments, [:attached_at_id, :attached_at_type]
  end

  def down
    drop_table :attachments
    remove_index :attachments, [:attached_at_id, :attached_at_type]
  end
end
