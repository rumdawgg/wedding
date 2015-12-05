class PhotosController < ApplicationController
  
  def new
    @photo = Photo.new
  end

  def show
  end

  def view
    @photos = Photo.all
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to @photo
    else
      render 'new'
    end
  end

  def show
    @photo = Photo.find params[:id]
  end

  def edit
    @photo = Photo.find params[:id]
  end

  def update
  @photo = Photo.find params[:id]

  if @photo.update_attributes(photo_params)
    redirect_to @photo
  else
    render :edit
    end
  end

  private
      def photo_params
          params.require(:photo).permit(:title, :caption, :file)
      end
  end