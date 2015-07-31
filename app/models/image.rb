# == Schema Information
#
# Table name: images
#
#  id                 :integer          not null, primary key
#  imageable_id       :integer
#  imageable_type     :string
#  image              :string
#  image_content_type :string
#  image_file_size    :integer
#  image_width        :integer
#  image_height       :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
end
