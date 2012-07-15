module ProfileHelper
  def avatar_of person, size= :large
    return person.profile.avatar_url(size)  if person.profile.avatar_url(size)
    (person.profile.gender == "female" ?  "default_avatar_female.jpg" : "default_avatar_male.jpg" )
  end
end
