class Person < ActiveRecord::Base
  include SocialSubject
  include FriendlyId

  include MembersHelper

  social_subject

  belongs_to :owner, :class_name => PERSON_OWNER

  has_one :role, :class_name => PERSON_ROLE
  has_one :profile, :dependent => :destroy, :class_name => "PersonProfile"
  has_one :timeline, :as => :owner, :dependent => :destroy

  has_many :received_followships, :class_name => "Followship", :as => :receiver, :dependent => :destroy
  has_many :sent_followships, :class_name => "Followship", :foreign_key => :sender_id, :dependent => :destroy
  has_many :lists, :class_name => "NamedList", :foreign_key => :owner_id, :dependent => :destroy
  has_many :permissions, :as=> :owner, :class_name => "SubjectPermission", :dependent => :destroy

  delegate :name, :to => :profile
  delegate :username, :to => :owner
  delegate :email, :to => :owner
  delegate :is?, :to => :role
  delegate :last_sign_in_at, :to => :owner

  paginates_per 10

  accepts_nested_attributes_for :profile, :timeline

  friendly_id :username, :use => :slugged

  default_scope includes(:profile, :timeline, :received_followships, :sent_followships)

  after_initialize :init

  class << self
    def build_from user, role, gender
      person = Person.create(owner: user)
      person.build_profile(name: user.username.titleize, gender: gender)
      person.build_timeline
      person.lists.build(name: "friends")
      person.lists.build(name: "public")
      person.save!
      PersonRole.create_role person, role
      person
    end
  end

  # Creates a timeline entry
  def create_timeline_entry creator, content, attach
    timeline.create_new_entry creator, content, attach
  end

  # Retrieve the default visibility for the timeline entries
  def default_visibility
    lists.where(name: :public).first
  end

  def visibility type
    lists.where(name: type).first || default_visibility
  end

  # Init method that creates the profile and timeline for the person
  def init
    self.profile ||= build_profile
    self.timeline ||= build_timeline
  end


  # Use this method to get the friends in common between this person and other subject
  # @param [Person/Other] receiver
  # @return [Array] with the friends in common
  def friends_in_common receiver
    self.friends(true) & receiver.friends(true) if receiver.respond_to? :friends
    []
  end

  # Search method that returns subjects that this person is connected to
  # @param [String] param to be searched
  # @param [Symbol] condition to be used in the search
  # @return [Array] with the elements that matches the param and condition
  def search param, condition=:all
    bulk = []
    bulk = ((followees + followers).uniq) if condition == :all
    bulk = followees if condition == :sent
    bulk = followers if condition == :received
    bulk.find_all{|p| p.name.match(/#{param}/i)}
  end


  # Retrieve the followers of this person
  # @param [Boolean] refresh if needed to fetch new record and not using the cache
  # @return [Array] of followers
  def followers refresh=false
    received_followships(refresh).collect(&:sender)
  end

  # Retrieve the followees of this person
  # @param [Boolean] refresh if needed to fetch new record and not using the cache
  # @return [Array] of followees
  def followees refresh=false
    sent_followships(refresh).collect(&:receiver)
  end

  # Retrieve the friends (that are simultaneously followers and followees) of this person
  # @param [Boolean] refresh if needed to fetch new record and not using the cache
  # @return [Array] of friends
  def friends refresh=false
    followers(refresh) & followees(refresh)
  end

  # Create a follow relation
  # @param [Person/Other] followee
  def follow followee
    sent_followships.create(receiver: followee)
  end

  # Destroy a current follow relation
  # @param [Person/Other] followee
  def unfollow followee
    followship = sent_followships.where(receiver_id: followee, receiver_type: followee.class.to_s).first
    follow = sent_followships.delete(followship)
    follow.first.destroy
  end

  # Defines the email method used by the plugins gem
  def mailboxer_email(object)
    return email
  end


  # Helper method that selects only id and name of this person to json
  def as_json(options={})
    {id: id, name: name}
  end

  #define_index do
  #  indexes profile.name, :as => :name
  #  indexes owner.email, :as => :email
  #end

end