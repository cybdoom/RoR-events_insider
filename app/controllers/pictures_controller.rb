class PicturesController < ApplicationController
  def create
    new_picture = Picture.create(file: params[:file])
    render json: {
      image: {
        url: new_picture.file_url#.split(File::Separator)[1..-1]
      }
    }, content_type: "text/html"
  end
end
