class CreatePersonProfiles < ActiveRecord::Migration
  def up
    create_table :person_profiles, :force => true do |t|
      t.belongs_to :person, :null => false
      t.string :name
      t.date :birthday
      t.string :gender
      t.string :country
      t.text :bio
      t.text :about
      t.string  :avatar, :default => ""
      t.timestamps
    end
    add_index :person_profiles, :person_id, :unique => true
  end

  def down
    drop_table :person_profiles
    remove_index :person_profiles, :person_id
  end
end
