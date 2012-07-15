require 'RMagick'

class Attachment < ActiveRecord::Base
  belongs_to :attached_at, :polymorphic => true

  attr_accessible :content, :content_cache, :attached_at_id

  mount_uploader :content, AttachmentUploader

  after_save :process_pdf

  def filename
    File.basename(content.url).chomp('.'+filetype)  if content.url
  end

  def filetype
    File.extname(content.url)[1..-1]  if content.url
  end

  def process_pdf(*args)
    if filetype == 'pdf'
      page = "#{content.path}[0]"
      image = Magick::Image.read(page)
      path = content.path.chomp(File.basename(content.url))
      image[0].write("#{path}/preview_#{self.filename}.jpg")
    end
  end

  def preview
    if content.url
      path = content.url.chomp(File.basename(content.url))
      location = ""
      location = "#{path}preview_#{self.filename}.jpg" if filetype == 'pdf'
      location
    end
  end

end