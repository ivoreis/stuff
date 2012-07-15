class ExpressionItem < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  has_one :attachment, :dependent => :destroy, :as => :attached_at

  social_object

  accepts_nested_attributes_for :attachment

  paginates_per 10

end
