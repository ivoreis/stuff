class PersonProfile < ActiveRecord::Base
  has_paper_trail :class_name => "PersonProfileVersion"
  belongs_to :person
  attr_accessible :avatar, :name, :avatar_cache, :gender, :country, :bio, :about, :birthday, :person_id

  mount_uploader :avatar, AvatarUploader

  attr_accessor :crop_x, :crop_y, :crop_h, :crop_w
  after_update :reprocess_profile, :if => :cropping?

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def profile_geometry
    img = Magick::Image::read(avatar.current_path).first
    @geometry = {:width => img.columns, :height => img.rows }
  end

  private

  def reprocess_profile
    avatar.recreate_versions!
  end

end
