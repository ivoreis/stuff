class AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include Sprockets::Helpers::RailsHelper

  storage :file

  version :large, :if => :image? do
    process :resize_to_fit => [125, 125]
  end

  version :thumb, :if => :image? do
    process :resize_to_fill => [60, 60]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def set_content_type(*args)
    self.file.instance_variable_set(:@content_type, "image/jpeg")
  end

  protected
    def image?(new_file)
      new_file.content_type.include? 'image'
    end
end
