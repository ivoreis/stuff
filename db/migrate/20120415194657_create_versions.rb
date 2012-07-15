class CreateVersions < ActiveRecord::Migration
  def self.up
    create_table :versions, :force => true do |t|
      t.string   :item_type, :null => false
      t.integer  :item_id,   :null => false
      t.string   :event,     :null => false
      t.string   :whodunnit
      t.text     :object
      t.datetime :created_at
    end
    add_index :versions, [:item_type, :item_id]

    create_table :person_profile_versions, :force => true do |t|
      t.string   :item_type, :null => false
      t.integer  :item_id,   :null => false
      t.string   :event,     :null => false
      t.string   :whodunnit
      t.text     :object
      t.datetime :created_at
    end
    add_index :person_profile_versions, [:item_type, :item_id]

  end

  def self.down
    remove_index :versions, [:item_type, :item_id]
    remove_index :person_profile_versions, [:item_type, :item_id]

    drop_table :versions
    drop_table :person_profile_versions
  end
end
