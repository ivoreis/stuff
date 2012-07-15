class TimelineEntry < ActiveRecord::Base
  ENTRY_TYPES = [:link, :photo, :text]
  mentions_field [:content]
  social_object

  belongs_to :timeline
  belongs_to :visibility, :class_name => "NamedList"
  belongs_to :owner, :polymorphic => true

  has_one :attachment, :dependent => :destroy, :as => :attached_at

  accepts_nested_attributes_for :attachment

  alias :comments :comment_threads

  attr_accessible :timeline, :visibility, :content, :system, :owner, :content_type, :owner_id, :timeline_id, :visibility_id, :attachment_id
  attr_accessible :comment_thread_ids
  before_save :prevent_defaults


  def prevent_defaults
    unless self.owner
      self.owner = timeline.owner
    end
    self.content_type = :photo
    self.visibility = owner.visibility(:friends)
  end

  def add_tag person, tags
    person.tag(self, :with => tags, :on => :tags)
  end

  def add_comment person, content
    comment(person, nil, content).save!
  end

end