class NamedList < ActiveRecord::Base
  belongs_to :owner, :class_name => "Person"
  has_many :entries, :class_name => "NamedListEntry"
  has_many :list_permissions
  has_many :timeline_entries, :foreign_key => :visibility_id

  attr_accessible :name, :owner, :owner_id, :entry_ids, :list_permission_ids, :timeline_entry_ids
end