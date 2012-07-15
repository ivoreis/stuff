class LibraryItem < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  has_one :attachment, :dependent => :destroy, :as => :attached_at
  accepts_nested_attributes_for :attachment

  social_object

  paginates_per 10
end
