class CreatePersonRoles < ActiveRecord::Migration
  def up
    create_table :person_roles, :force => true do |t|
      t.belongs_to :person, :null => false
      t.string :name, :null => false
    end
    add_index :person_roles, :person_id, :unique =>  true
  end

  def down
    drop_table :person_roles
    remove_index :person_roles, :person_id
  end
end
