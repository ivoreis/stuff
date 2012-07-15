ROLES = [:member, :moderator, :staff]

class PersonRole < ActiveRecord::Base
  belongs_to :person
  validates_inclusion_of :name, :in => ROLES

  class << self
    def create_role person, role
      PersonRole.create(person: person, name: role)
    end
  end

  def is? role
     self.name == role
  end

  def name
    read_attribute(:name).to_sym if read_attribute(:name)
  end

  def name= value
    write_attribute :name, value.to_s
  end
end

