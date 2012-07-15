module SocialObject
  extend ActiveSupport::Concern

  module ClassMethods
    def social_object
      acts_as_commentable
      acts_as_mentionable :notify => false
      acts_as_favorable
      acts_as_taggable
      acts_as_viewable
      acts_as_votable
      has_paper_trail
    end
  end
end

ActiveRecord::Base.send :include, SocialObject
