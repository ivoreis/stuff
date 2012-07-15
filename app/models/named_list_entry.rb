class NamedListEntry < ActiveRecord::Base
  belongs_to :named_list
  belongs_to :person
end