# TODO: pull common code for uploaders in EventsInsider::BaseUploader and inherit from it
# TODO: use Amazon S3 for storage in production but filesystem in development
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MagicMimeTypes
  include CarrierWave::Uploader::MagicMimeWhitelist

  process :set_content_type
  process :store_dimensions

  IMAGE_EXTENTIONS = %w(jpg jpeg gif png).freeze

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    ActionController::Base.helpers.asset_path('placeholders/' + [version_name, 'default.png'].compact.join('_'))
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    IMAGE_EXTENTIONS
  end

  def whitelist_mime_type_pattern
    /image\//
  end

  private

  def store_dimensions
    if file && model
      model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
