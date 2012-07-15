class ListPermission < ActiveRecord::Base
  belongs_to :named_list
  belongs_to :permission
end