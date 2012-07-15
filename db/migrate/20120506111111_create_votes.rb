class CreateVotes < ActiveRecord::Migration
  def up
    create_table :votes, :force => true do |t|
      t.belongs_to :votable, :polymorphic => true, :null => false
      t.belongs_to :voter, :polymorphic => true,:null => false
      t.boolean :vote_flag
      t.timestamps
    end
    add_index :votes, [:votable_id, :votable_type]
    add_index :votes, [:voter_id, :voter_type]
    add_index :votes, [:voter_id, :voter_type,:votable_id, :votable_type], :unique => true, :name => :unique_index_votes
  end

  def down
    drop_table :votes
    remove_index :votes, [:votable_id, :votable_type]
    remove_index :votes, [:voter_id, :voter_type]
    remove_index :votes, [:voter_id, :voter_type,:votable_id, :votable_type], :unique => true
  end
end