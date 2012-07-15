class CreateExpressionItems < ActiveRecord::Migration
  def up
    create_table :expression_items do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.belongs_to :owner, :polymorphic => true, :null => false
      t.timestamps
    end
    add_index :expression_items, [:owner_id, :owner_type]
  end

  def down
    drop_table :expression_items
    remove_index :expression_items, [:owner_id, :owner_type]
  end
end
