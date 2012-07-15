class CreateFollowships < ActiveRecord::Migration
  def up
    create_table :followships, :force => true do |t|
      t.belongs_to :sender, :null => false
      t.belongs_to :receiver, :polymorphic => true, :null => false
      t.timestamps
    end
    add_index :followships, [:sender_id, :receiver_id, :receiver_type], :unique => true, :name => :index_followships
  end

  def down
    drop_table :followships
    remove_index :followships, [:sender_id, :receiver_id, :receiver_type]
  end
end
