class PhotosController < ApplicationController
  def index
    @list_of_photos = Photo.all
  end

def show
render("show.html.erb")
end

end
