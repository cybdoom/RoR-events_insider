# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Picture < ActiveRecord::Base
  mount_uploader :file, PictureUploader
end
