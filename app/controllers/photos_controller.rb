class PhotosController < ApplicationController
  def index
    @list_of_photos = Photo.all
  end

def show
render("photos/application.html.erb")
end

end
