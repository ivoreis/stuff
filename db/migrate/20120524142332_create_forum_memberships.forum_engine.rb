# This migration comes from forum_engine (originally 20120418122509)
class CreateForumMemberships < ActiveRecord::Migration
  def change
    create_table :forum_memberships do |t|
      t.belongs_to :room
      t.belongs_to :member
      t.timestamps
    end
    add_index :forum_memberships, [:room_id, :member_id], :unique => true
  end

end
