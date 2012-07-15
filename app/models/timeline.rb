class Timeline < ActiveRecord::Base

  belongs_to :owner, :polymorphic => true
  has_many :entries, :class_name => "TimelineEntry", :dependent => :destroy
  default_scope includes(:entries)
  accepts_nested_attributes_for :entries


  def create_new_entry creator, content, attach
    new_entry  = entries.build
    if attach
      new_entry.build_attachment(content: attach)
    end
    new_entry.content = content
    new_entry.owner = creator
    new_entry
  end
end