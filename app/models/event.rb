class Event < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  belongs_to :creator, :polymorphic => true
  attr_accessor :starts_hour, :ends_hour

  scope :before, lambda {|end_time| {:conditions => ["ends_at < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}

  scope :by_owner, lambda{ |owner|
    where(owner_id: owner, owner_type: owner.class.to_s)
  }

  def as_json(options = {})
    {
        :id => self.id,
        :title => self.title,
        :details => self.details || "",
        :start => self.starts_at.rfc822,
        :end => self.ends_at.rfc822,
        :allDay => self.all_day,
        :recurring => self.repeat
    }
  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

end
