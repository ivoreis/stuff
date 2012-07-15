class Permission < ActiveRecord::Base
  serialize :options
  belongs_to :action_permission
  belongs_to :predicate_permission
end