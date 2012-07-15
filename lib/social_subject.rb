module SocialSubject
  extend ActiveSupport::Concern

  module ClassMethods
    def social_subject
      activist
      acts_as_voter
      acts_as_commenter
      acts_as_favoriter
      acts_as_tagger
      acts_as_mentionable
      acts_as_messageable
    end
  end
end

ActiveRecord::Base.send :include, SocialSubject
