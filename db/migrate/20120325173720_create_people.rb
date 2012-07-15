class CreatePeople < ActiveRecord::Migration
  def up
    create_table :people, :force => true do |t|
      t.belongs_to :owner
      t.string :slug, :null => false
      t.timestamps
    end
    add_index :people, :owner_id
    add_index :people, :slug, :unique => true
  end

  def down
    drop_table :people
    remove_index :people, :owner_id
  end
end
