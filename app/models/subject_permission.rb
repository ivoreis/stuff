class SubjectPermission < ActiveRecord::Base
  belongs_to :permission
  belongs_to :owner, :polymorphic => true
end