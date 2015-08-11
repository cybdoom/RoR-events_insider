class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MagicMimeTypes
  # include CarrierWave::Uploader::MagicMimeWhitelist

  process :validate_dimensions
  process :set_content_type
  process :store_dimensions
  process :save_content_type_and_size_in_model
  process :strip

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL to placeholder image if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    asset_path('placeholders/' + [version_name, 'default.png'].compact.join('_'))
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
    %w(jpg jpeg gif png bmp)
  end

  def whitelist_mime_type_pattern
    /image\//
  end

  def remove!
    return super if !Rails.env.production?
    begin
      super
    rescue Fog::Storage::AWS::NotFound
    end
  end

  protected

  def width_attr
    :"{mounted_as}_width"
  end

  def height_attr
    :"{mounted_as}_height"
  end

  def content_type_attr
    :"#{mounted_as}_content_type"
  end

  def file_size_attr
    :"#{mounted_as}_file_size"
  end

  def store_dimensions
    if file && model
      width, height = ::MiniMagick::Image.open(file.file)[:dimensions]
      model.send(width_attr, width)
      model.send(height_attr, height)
    end
  end

  def save_content_type_and_size_in_model
    model.send(content_type_attr, file.content_type) if file.content_type
    model.send(file_size_attr, file.size)
  end

end
