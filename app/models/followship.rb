class Followship < ActiveRecord::Base
  traceable :only => [:create]
  belongs_to :sender,   :class_name => "Person"
  belongs_to :receiver, :polymorphic => true
  alias :owner :sender

  paginates_per 10
end